#include "mgfx_roundrect_common.hlsl"

#define GLOW_COLOR EXTRA0
#define GLOW_WIDTH EXTRA2.x
#define GLOW_STRENGTH EXTRA2.y
#define GLOW_FALLOFF EXTRA2.z

float inner_glow_profile(float depth, float width, float falloff)
{
	return mgfx_css_inner_effect(depth, width, falloff);
}

float roundrect_inner_glow(float2 pos, float2 size, float width, float falloff)
{
	float effect = 0.0;
	effect = mgfx_css_combine_effect(effect, inner_glow_profile(pos.x, width, falloff));
	effect = mgfx_css_combine_effect(effect, inner_glow_profile(size.x - pos.x, width, falloff));
	effect = mgfx_css_combine_effect(effect, inner_glow_profile(pos.y, width, falloff));
	effect = mgfx_css_combine_effect(effect, inner_glow_profile(size.y - pos.y, width, falloff));
	return effect;
}

float4 main(PS_INPUT i) : COLOR
{
	float2 pos = i.uv * SIZE;
	float2 halfSize = SIZE * 0.5;
	float radius = min(SHAPE_RADIUS, min(halfSize.x, halfSize.y));
	float width = max(GLOW_WIDTH, 0.001);
	float falloff = max(GLOW_FALLOFF, 0.001);

	float outerDist = sd_roundrect(pos - halfSize, halfSize, radius);
	float shape = roundrect_coverage_from_dist(outerDist);
	float glow = roundrect_inner_glow(pos, SIZE, width, falloff) * shape * max(GLOW_STRENGTH, 0.0);
	float alpha = saturate(GLOW_COLOR.a * glow);

	clip(alpha - 0.001);
	return float4(saturate(GLOW_COLOR.rgb), alpha);
}
