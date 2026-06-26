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

#include "mgfx_pattern_common.hlsl"

float4 main(PS_INPUT i) : COLOR
{
	float2 pos = i.uv * SIZE;
	float shape = roundrect_coverage(i.uv);
	float dist = roundrect_dist_px(pos);
	float stripe = pattern_stripe_coverage(pos, PATTERN_DIR, PATTERN_SPACING, PATTERN_WIDTH, PATTERN_OFFSET);
	float smoke = pattern_smoke_coverage(pos, PATTERN_DIR, PATTERN_SPACING, PATTERN_WIDTH, PATTERN_OFFSET, PATTERN_SOFTNESS, PATTERN_WARP, PATTERN_SEED);
	float4 wornTerms = pattern_worn_terms(pos, dist, PATTERN_DIR, PATTERN_SPACING, PATTERN_OFFSET, PATTERN_WIDTH, PATTERN_SEED);
	float worn = max(max(wornTerms.x, wornTerms.y), max(wornTerms.z, wornTerms.w));
	float pattern = PATTERN_KIND < 0.5 ? stripe : (PATTERN_KIND < 1.5 ? smoke : worn);
	float alpha = PATTERN_COLOR.a * shape * pattern;
	clip(alpha - 0.001);
	float4 color = PATTERN_KIND < 1.5 ? PATTERN_COLOR * (shape * pattern) : pattern_worn_color(PATTERN_COLOR, wornTerms, shape);
	return float4(saturate(color.rgb), saturate(color.a));
}
