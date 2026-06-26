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
#include "mgfx_pattern_common.hlsl"

float4 main(PS_INPUT i) : COLOR
{
	float2 pos = i.uv * SHAPE_SIZE;
	float dist = chamfer_dist_shape(pos, SHAPE_SIZE, CHAMFER_CUTS);
	float shape = aa_coverage(dist);
	float stripe = pattern_stripe_coverage(pos, PATTERN_DIR, PATTERN_SPACING, PATTERN_WIDTH, PATTERN_OFFSET);
	float smoke = pattern_smoke_coverage(pos, PATTERN_DIR, PATTERN_SPACING, smoke_density(), PATTERN_OFFSET, smoke_softness(), smoke_warp(), PATTERN_SEED);
	float4 wornTerms = pattern_worn_terms(pos, dist, PATTERN_DIR, PATTERN_SPACING, PATTERN_OFFSET, PATTERN_WIDTH, PATTERN_SEED);
	float worn = max(max(wornTerms.x, wornTerms.y), max(wornTerms.z, wornTerms.w));
	float pattern = PATTERN_KIND < 0.5 ? stripe : (PATTERN_KIND < 1.5 ? smoke : worn);
	float alpha = PATTERN_COLOR.a * shape * pattern;
	clip(alpha - 0.001);
	float4 color = PATTERN_KIND < 1.5 ? PATTERN_COLOR * (shape * pattern) : pattern_worn_color(PATTERN_COLOR, wornTerms, shape);
	return float4(saturate(color.rgb), saturate(color.a));
}
