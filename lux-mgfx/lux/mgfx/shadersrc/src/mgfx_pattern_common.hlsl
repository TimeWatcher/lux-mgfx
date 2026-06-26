#ifndef MGFX_PATTERN_COMMON_HLSL
#define MGFX_PATTERN_COMMON_HLSL

#define WORN_EDGE_COLOR AUX0
#define WORN_FRACTAL AUX1.x
#define WORN_GRAIN AUX1.y
#define WORN_SCRATCHES AUX1.z
#define WORN_EDGE AUX1.w
#define WORN_GRAIN_SCALE AUX2.x
#define WORN_SCRATCH_SCALE AUX2.y
#define WORN_SCRATCH_WIDTH AUX2.z
#define WORN_EDGE_WIDTH AUX2.w
#define WORN_DIR AUX3.xy
#define WORN_SOFTNESS AUX3.z
#define WORN_WARP AUX3.w

float pattern_hash21(float2 p, float seed)
{
	return frac(sin(dot(p, float2(127.1 + seed * 19.19, 311.7 + seed * 37.37)) + seed * 101.3) * (43758.5453123 + seed * 1024.0));
}

float pattern_value_noise(float2 p, float seed)
{
	float2 i = floor(p);
	float2 f = frac(p);
	float2 u = f * f * (3.0 - 2.0 * f);

	float a = pattern_hash21(i, seed);
	float b = pattern_hash21(i + float2(1.0, 0.0), seed);
	float c = pattern_hash21(i + float2(0.0, 1.0), seed);
	float d = pattern_hash21(i + float2(1.0, 1.0), seed);

	return lerp(lerp(a, b, u.x), lerp(c, d, u.x), u.y);
}

float pattern_fbm(float2 p, float seed)
{
	float n = pattern_value_noise(p, seed) * 0.54;
	n += pattern_value_noise(p * 2.03 + float2(17.31, 9.17), seed + 0.17) * 0.29;
	n += pattern_value_noise(p * 4.11 + float2(43.79, 21.23), seed + 0.31) * 0.17;
	return n;
}

float pattern_line_mask(float coord, float width)
{
	float band = abs(frac(coord) - 0.5);
	return smoothstep(width, 0.0, band);
}

float pattern_remap01(float value, float low, float high)
{
	return saturate((value - low) / max(high - low, 0.0001));
}

float2 pattern_surface_roughness_terms(float2 pos, float grainScale, float seed)
{
	grainScale = max(grainScale, 0.25);
	float fineA = pattern_value_noise(pos / max(6.2 / grainScale, 1.2), seed + 1.10);
	float fineB = pattern_value_noise(pos / max(13.0 / grainScale, 2.0) + float2(13.1, 9.7), seed + 1.70);
	float fineC = pattern_value_noise(pos / max(28.0 / grainScale, 3.5) + float2(31.0, 27.0), seed + 2.30);
	float centered = (fineA * 0.48 + fineB * 0.34 + fineC * 0.18) - 0.5;
	return float2(
		pattern_remap01(-centered * 2.0, 0.02, 0.82),
		pattern_remap01(centered * 2.0, 0.10, 0.82)
	);
}

float pattern_segment_mask(float2 p, float2 a, float2 b, float width)
{
	float2 pa = p - a;
	float2 ba = b - a;
	float h = saturate(dot(pa, ba) / max(dot(ba, ba), 0.0001));
	float dist = length(pa - ba * h);
	float endFade = smoothstep(0.0, 0.16, h) * (1.0 - smoothstep(0.84, 1.0, h));
	return (1.0 - smoothstep(width * 0.45, width * 2.2, dist)) * endFade;
}

float pattern_short_scratch(float2 pos, float2 baseDir, float cellSize, float width01, float density, float seed)
{
	cellSize = max(cellSize, 8.0);
	width01 = max(width01, 0.005);
	density = saturate(density);
	float2 cell = floor(pos / cellSize);
	float2 localPos = pos / cellSize;
	float outMask = 0.0;

	for (int y = -1; y <= 1; y++)
	{
		for (int x = -1; x <= 1; x++)
		{
			float2 g = cell + float2(x, y);
			float r0 = pattern_hash21(g, seed + 0.11);
			float threshold = 0.935 - density * 0.18;
			if (r0 < threshold)
				continue;

			float r1 = pattern_hash21(g + float2(13.0, 7.0), seed + 0.29);
			float r2 = pattern_hash21(g + float2(3.0, 19.0), seed + 0.47);
			float r3 = pattern_hash21(g + float2(23.0, 5.0), seed + 0.71);
			float jitter = (r1 - 0.5) * 0.55;
			float s = sin(jitter);
			float c = cos(jitter);
			float2 dir = normalize(float2(baseDir.x * c - baseDir.y * s, baseDir.x * s + baseDir.y * c));
			float2 center = g + float2(0.18 + 0.64 * r2, 0.18 + 0.64 * r3);
			float len = 0.25 + 0.80 * pattern_hash21(g + float2(31.0, 37.0), seed + 0.83);
			float width = max(0.45, width01 * 11.0) / cellSize;
			outMask = max(outMask, pattern_segment_mask(localPos, center - dir * len * 0.5, center + dir * len * 0.5, width));
		}
	}

	return outMask;
}

float pattern_soft_scuff(float2 pos, float scale, float amount, float seed)
{
	scale = max(scale, 8.0);
	amount = saturate(amount);
	float n1 = pattern_fbm(pos / scale, seed + 0.77);
	float n2 = pattern_fbm(pos / max(scale * 0.42, 3.0) + float2(19.0, 11.0), seed + 0.91);
	float highPass = abs(n1 - n2) * 1.9;
	float soft = smoothstep(0.46 + 0.16 * (1.0 - amount), 0.80, highPass) * amount;
	float breakup = pattern_value_noise(pos / 5.0 + float2(8.0, 3.0), seed + 3.10);
	return soft * smoothstep(0.18, 0.72, breakup);
}

float pattern_edge_wear(float2 pos, float innerDepth, float2 dir, float edgeWidth, float scratchDensity, float seed)
{
	edgeWidth = max(edgeWidth, 0.5);
	float band = saturate(1.0 - innerDepth / edgeWidth);
	float noise = pattern_value_noise(pos / 3.2 + float2(7.1, 19.2), seed + 0.89) * 0.45
		+ pattern_value_noise(pos / 9.5, seed + 0.94) * 0.28
		+ pattern_value_noise(pos / 1.8, seed + 0.97) * 0.27;
	float broken = smoothstep(0.50, 0.84, noise);
	float edgeScratch = pattern_short_scratch(pos + float2(11.0, 5.0), dir, 10.0, 0.045, saturate(scratchDensity + 0.18), seed + 1.20);
	return pow(band, 1.45) * (broken * 0.75 + edgeScratch * 0.45);
}

float pattern_stripe_coverage(float2 pos, float2 dir, float spacing, float width, float offset)
{
	spacing = max(spacing, 0.001);
	width = max(width, 0.001);
	float coord = dot(pos, dir) + offset;
	float band = abs(frac(coord / spacing) - 0.5) * spacing;
	return aa_coverage(band - width * 0.5);
}

float pattern_smoke_coverage(float2 pos, float2 dir, float scale, float density, float offset, float softness, float warpAmount, float seed)
{
	scale = max(scale, 1.0);
	density = saturate(density);
	softness = max(softness, 0.001);
	seed = saturate(seed);
	float2 p = pos / scale + dir * offset;

	float warpA = pattern_value_noise(p * 0.71 + float2(11.8, 3.1), seed);
	float warpB = pattern_value_noise(p * 0.67 + float2(2.7, 19.4), seed);
	float2 warp = (float2(warpA, warpB) - 0.5) * max(warpAmount, 0.0);
	p += warp;

	float n = pattern_fbm(p, seed);
	return smoothstep(density - softness, density + softness, n);
}

float4 pattern_worn_terms(float2 pos, float distPx, float2 dir, float scale, float offset, float edgeWidth, float seed)
{
	seed = saturate(seed);
	scale = max(scale, 1.0);
	edgeWidth = max(edgeWidth, 0.5);

	float2 scratchBase = abs(WORN_DIR.x) + abs(WORN_DIR.y) > 0.0001 ? WORN_DIR : dir;
	float2 scratchDir = normalize(scratchBase);
	float2 surfacePos = pos + dir * offset * scale;
	float warpA = pattern_value_noise(surfacePos / scale + float2(8.3, 15.1), seed + 0.41);
	float warpB = pattern_value_noise(surfacePos / scale + float2(19.7, 4.4), seed + 0.59);
	surfacePos += (float2(warpA, warpB) - 0.5) * WORN_WARP * scale;

	// Worn is a material-state change, not a grunge decal. The base surface is
	// only dulled a little; visible marks come from fine scratches, sparse soft
	// scuffs, and broken edge wear.
	float2 rough = pattern_surface_roughness_terms(surfacePos, WORN_GRAIN_SCALE, seed);
	float scratches = pattern_short_scratch(surfacePos, scratchDir, WORN_SCRATCH_SCALE, WORN_SCRATCH_WIDTH, WORN_SCRATCHES, seed + 0.37);

	float innerDepth = max(-distPx, 0.0);
	float edgeWear = pattern_edge_wear(surfacePos, innerDepth, scratchDir, edgeWidth, WORN_SCRATCHES, seed) * WORN_EDGE;
	float scuffs = pattern_soft_scuff(surfacePos, scale, WORN_FRACTAL, seed);

	float strength = saturate(WORN_FRACTAL * 0.50 + WORN_GRAIN * 0.35 + WORN_EDGE * 0.15);
	float roughDark = saturate(rough.x * WORN_GRAIN * 0.32);
	float roughLight = saturate(rough.y * WORN_GRAIN * 0.12);
	float darkTerm = saturate(strength * 0.045 + roughDark + scuffs * WORN_FRACTAL * 0.30 + edgeWear * 0.16);
	float lightTerm = saturate(roughLight + scratches * WORN_SCRATCHES * 0.52);
	float edgeTerm = saturate(edgeWear * 0.95);
	return saturate(float4(darkTerm, roughDark, lightTerm, edgeTerm));
}

float pattern_worn_coverage(float2 pos, float distPx, float2 dir, float scale, float offset, float edgeWidth, float seed)
{
	float4 terms = pattern_worn_terms(pos, distPx, dir, scale, offset, edgeWidth, seed);
	return saturate(max(max(terms.x, terms.y), max(terms.z, terms.w)));
}

float4 pattern_worn_color(float4 patternColor, float4 terms, float shapeCoverage)
{
	float dark = saturate(terms.x + terms.y);
	float light = saturate(terms.z + terms.w);
	float darkAlpha = dark * patternColor.a;
	float lightAlpha = light * WORN_EDGE_COLOR.a;
	float alpha = saturate((darkAlpha + lightAlpha) * shapeCoverage);
	float3 rgb = (patternColor.rgb * darkAlpha + WORN_EDGE_COLOR.rgb * lightAlpha) / max(darkAlpha + lightAlpha, 0.0001);
	return float4(saturate(rgb), alpha);
}

#endif
