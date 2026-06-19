#include "mgfx_roundrect_common.hlsl"

#define PATTERN_COLOR EXTRA0
#define PATTERN_DIR EXTRA2.xy
#define PATTERN_SPACING EXTRA2.z
#define PATTERN_WIDTH EXTRA2.w
#define PATTERN_SEED EXTRA1.z
#define PATTERN_OFFSET EXTRA3.x
#define PATTERN_KIND EXTRA3.y
#define PATTERN_SOFTNESS EXTRA3.z
#define PATTERN_WARP EXTRA3.w

float stripe_coverage(float2 pos)
{
	float spacing = max(PATTERN_SPACING, 0.001);
	float width = max(PATTERN_WIDTH, 0.001);
	float coord = dot(pos, PATTERN_DIR) + PATTERN_OFFSET;
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
	float softness = max(PATTERN_SOFTNESS, 0.001);
	float seed = saturate(PATTERN_SEED);
	float2 p = pos / scale + PATTERN_DIR * PATTERN_OFFSET;

	float warpA = value_noise(p * 0.71 + float2(11.8, 3.1), seed);
	float warpB = value_noise(p * 0.67 + float2(2.7, 19.4), seed);
	float2 warp = (float2(warpA, warpB) - 0.5) * PATTERN_WARP;
	p += warp;

	float n = value_noise(p, seed) * 0.56;
	n += value_noise(p * 2.03 + 17.31, seed) * 0.29;
	n += value_noise(p * 4.11 + 43.79, seed) * 0.15;

	return smoothstep(density - softness, density + softness, n);
}

float4 main(PS_INPUT i) : COLOR
{
	float2 pos = i.uv * SIZE;
	float shape = roundrect_coverage(i.uv);
	float pattern = PATTERN_KIND < 0.5 ? stripe_coverage(pos) : smoke_coverage(pos);
	float alpha = PATTERN_COLOR.a * shape * pattern;
	clip(alpha - 0.001);
	return float4(saturate(PATTERN_COLOR.rgb), saturate(alpha));
}
