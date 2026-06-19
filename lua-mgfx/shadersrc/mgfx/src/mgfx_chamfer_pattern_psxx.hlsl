#include "mgfx_common.hlsl"

#define PATTERN_COLOR EXTRA0
#define SHAPE_SIZE EXTRA1.xy
#define PATTERN_DIR EXTRA2.xy
#define PATTERN_SPACING EXTRA2.z
#define PATTERN_WIDTH EXTRA2.w
#define CHAMFER_CUTS EXTRA3
#define PATTERN_OFFSET EXTRA1.z
#define PATTERN_KIND_SEED EXTRA1.w
#define PATTERN_KIND floor(PATTERN_KIND_SEED + 0.0001)
#define PATTERN_SEED frac(PATTERN_KIND_SEED)

float packed_byte(float packed, float scale)
{
	return fmod(floor(packed / scale), 256.0);
}

float smoke_density()
{
	return saturate(packed_byte(PATTERN_WIDTH, 1.0) / 255.0);
}

float smoke_softness()
{
	return max(packed_byte(PATTERN_WIDTH, 256.0) / 255.0, 0.001);
}

float smoke_warp()
{
	return saturate(packed_byte(PATTERN_WIDTH, 65536.0) / 255.0);
}

#include "mgfx_chamfer_common.hlsl"

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
	float density = smoke_density();
	float softness = smoke_softness();
	float seed = saturate(PATTERN_SEED);
	float2 p = pos / scale + PATTERN_DIR * PATTERN_OFFSET;

	float warpA = value_noise(p * 0.71 + float2(11.8, 3.1), seed);
	float warpB = value_noise(p * 0.67 + float2(2.7, 19.4), seed);
	float2 warp = (float2(warpA, warpB) - 0.5) * smoke_warp();
	p += warp;

	float n = value_noise(p, seed) * 0.56;
	n += value_noise(p * 2.03 + 17.31, seed) * 0.29;
	n += value_noise(p * 4.11 + 43.79, seed) * 0.15;

	return smoothstep(density - softness, density + softness, n);
}

float4 main(PS_INPUT i) : COLOR
{
	float2 pos = i.uv * SHAPE_SIZE;
	float dist = chamfer_dist_shape(pos, SHAPE_SIZE, CHAMFER_CUTS);
	float shape = aa_coverage(dist);
	float spacing = max(PATTERN_SPACING, 0.001);
	float width = max(PATTERN_WIDTH, 0.001);
	float band = abs(frac((dot(pos, PATTERN_DIR) + PATTERN_OFFSET) / spacing) - 0.5) * spacing;
	float stripe = aa_coverage(band - width * 0.5);
	float pattern = PATTERN_KIND < 0.5 ? stripe : smoke_coverage(pos);
	float alpha = PATTERN_COLOR.a * shape * pattern;
	clip(alpha - 0.001);
	return float4(saturate(PATTERN_COLOR.rgb), saturate(alpha));
}
