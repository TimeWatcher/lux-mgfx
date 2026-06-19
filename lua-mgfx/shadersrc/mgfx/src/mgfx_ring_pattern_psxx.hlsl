#include "mgfx_common.hlsl"

#define PATTERN_EXTRA EXTRA0
#define DRAW_SIZE EXTRA1.xy
#define INNER_RADIUS EXTRA1.z
#define OUTER_RADIUS EXTRA1.w
#define START_RAD EXTRA2.x
#define END_RAD EXTRA2.y
#define ARC_MODE EXTRA2.z
#define PATTERN_KIND EXTRA2.w
#define PATTERN_DIR EXTRA3.xy
#define PATTERN_SPACING EXTRA3.z
#define PATTERN_WIDTH EXTRA3.w

float normalize_angle(float a)
{
	return a < 0.0 ? a + 6.28318530718 : a;
}

float ring_band_dist(float r, float innerR, float outerR)
{
	if (innerR <= 0.001)
		return r - outerR;

	float halfW = (outerR - innerR) * 0.5;
	float midR = (outerR + innerR) * 0.5;
	return abs(r - midR) - halfW;
}

float radial_segment_dist(float2 p, float angle, float innerR, float outerR)
{
	float2 dir = float2(cos(angle), sin(angle));
	float along = clamp(dot(p, dir), innerR, outerR);
	return length(p - dir * along);
}

float ring_dist(float2 p)
{
	float r = length(p);
	float innerR = max(INNER_RADIUS, 0.0);
	float outerR = max(OUTER_RADIUS, innerR + 0.001);
	float halfW = (outerR - innerR) * 0.5;
	float midR = (outerR + innerR) * 0.5;
	float bandDist = ring_band_dist(r, innerR, outerR);
	float dist = bandDist;
	float span = END_RAD - START_RAD;

	if (span < 0.0)
		span += 6.28318530718;

	if (ARC_MODE > 0.5 && span < 6.282)
	{
		float angle = normalize_angle(atan2(p.y, p.x));
		float startA = normalize_angle(START_RAD);
		float localA = angle - startA;
		if (localA < 0.0)
			localA += 6.28318530718;

		float inArc = step(localA, span);
		float endA = startA + span;

		if (ARC_MODE < 1.5)
		{
			float2 startP = float2(cos(startA), sin(startA)) * midR;
			float2 endP = float2(cos(endA), sin(endA)) * midR;
			float capDist = min(length(p - startP), length(p - endP)) - halfW;
			dist = lerp(capDist, bandDist, inArc);
		}
		else
		{
			float capDist = min(
				radial_segment_dist(p, startA, innerR, outerR),
				radial_segment_dist(p, endA, innerR, outerR)
			);
			dist = max(bandDist, lerp(capDist, -capDist, inArc));
		}
	}

	return dist;
}

float stripe_coverage(float2 pos)
{
	float spacing = max(PATTERN_SPACING, 0.001);
	float width = max(PATTERN_WIDTH, 0.001);
	float coord = dot(pos, PATTERN_DIR) + PATTERN_EXTRA.y;
	float band = abs(frac(coord / spacing) - 0.5) * spacing;
	return aa_coverage(band - width * 0.5);
}

float hash21(float2 p, float seed)
{
	return frac(sin(dot(p, float2(127.1 + seed * 19.19, 311.7 + seed * 37.37)) + seed * 101.3) * (43758.5453123 + seed * 1024.0));
}

float value_noise(float2 p, float seed)
{
	float2 i = floor(p);
	float2 f = frac(p);
	float2 u = f * f * (3.0 - 2.0 * f);

	float a = hash21(i, seed);
	float b = hash21(i + float2(1.0, 0.0), seed);
	float c = hash21(i + float2(0.0, 1.0), seed);
	float d = hash21(i + float2(1.0, 1.0), seed);

	return lerp(lerp(a, b, u.x), lerp(c, d, u.x), u.y);
}

float smoke_coverage(float2 pos)
{
	float scale = max(PATTERN_SPACING, 1.0);
	float density = saturate(PATTERN_WIDTH);
	float softness = max(PATTERN_EXTRA.z, 0.001);
	float seed = saturate(PATTERN_EXTRA.x);
	float2 p = pos / scale + PATTERN_DIR * PATTERN_EXTRA.y;

	float warpA = value_noise(p * 0.71 + float2(11.8, 3.1), seed);
	float warpB = value_noise(p * 0.67 + float2(2.7, 19.4), seed);
	float2 warp = (float2(warpA, warpB) - 0.5) * PATTERN_EXTRA.w;
	p += warp;

	float n = value_noise(p, seed) * 0.56;
	n += value_noise(p * 2.03 + 17.31, seed) * 0.29;
	n += value_noise(p * 4.11 + 43.79, seed) * 0.15;

	return smoothstep(density - softness, density + softness, n);
}

float4 main(PS_INPUT i) : COLOR
{
	float2 p = (i.uv - 0.5) * DRAW_SIZE;
	float shape = aa_coverage(ring_dist(p));
	float2 pos = i.uv * DRAW_SIZE;
	float pattern = PATTERN_KIND < 0.5 ? stripe_coverage(pos) : smoke_coverage(pos);
	float alpha = i.color.a * shape * pattern;
	clip(alpha - 0.001);
	return float4(saturate(i.color.rgb), saturate(alpha));
}
