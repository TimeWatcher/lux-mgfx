#include "mgfx_common.hlsl"

#define DRAW_SIZE EXTRA0.xy
#define SHADOW_COLOR EXTRA1
#define SHADOW_SHAPE EXTRA2
#define SHADOW_PARAMS EXTRA3

#define OUTER_COLOR AUX0
#define OUTER_SHAPE AUX1
#define OUTER_PARAMS AUX2

float sd_roundrect(float2 p, float2 halfSize, float radius)
{
	float2 q = abs(p) - halfSize + radius;
	return min(max(q.x, q.y), 0.0) + length(max(q, 0.0)) - radius;
}

float shape_dist(float2 pos, float4 shape, float radius)
{
	float2 size = max(shape.zw, float2(0.001, 0.001));
	float2 halfSize = size * 0.5;
	float r = min(max(radius, 0.0), min(halfSize.x, halfSize.y));
	return sd_roundrect(pos - shape.xy - halfSize, halfSize, r);
}

float4 source_over(float4 top, float4 bottom)
{
	float alpha = top.a + bottom.a * (1.0 - top.a);
	float3 rgb = (top.rgb * top.a + bottom.rgb * bottom.a * (1.0 - top.a)) / max(alpha, 0.0001);
	return float4(saturate(rgb), saturate(alpha));
}

float4 main(PS_INPUT i) : COLOR
{
	float2 pos = i.uv * DRAW_SIZE;

	float shadowDist = shape_dist(pos, SHADOW_SHAPE, SHADOW_PARAMS.x);
	float shadowEffect =
		mgfx_css_shadow_effect(shadowDist, max(SHADOW_PARAMS.y, 0.001), max(SHADOW_PARAMS.w, 0.001))
		* max(SHADOW_PARAMS.z, 0.0);
	float4 shadowColor = float4(saturate(SHADOW_COLOR.rgb), saturate(SHADOW_COLOR.a * shadowEffect));

	float outerDist = shape_dist(pos, OUTER_SHAPE, OUTER_PARAMS.x);
	float outerEffect =
		mgfx_css_outer_effect(outerDist, max(OUTER_PARAMS.y, 0.001), max(OUTER_PARAMS.w, 0.001))
		* max(OUTER_PARAMS.z, 0.0);
	float4 outerColor = float4(saturate(OUTER_COLOR.rgb), saturate(OUTER_COLOR.a * outerEffect));

	float4 color = source_over(outerColor, shadowColor);
	clip(color.a - 0.001);
	return color;
}
