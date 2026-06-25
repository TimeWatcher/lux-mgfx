#include "mgfx_common.hlsl"
#include "mgfx_chamfer_common.hlsl"

#define DRAW_SIZE EXTRA0.xy
#define SHADOW_WIDTH EXTRA0.z
#define SHADOW_STRENGTH EXTRA0.w
#define SHADOW_COLOR EXTRA1
#define SHADOW_SHAPE EXTRA2
#define SHADOW_CUTS EXTRA3

#define OUTER_COLOR AUX0
#define OUTER_SHAPE AUX1
#define OUTER_CUTS AUX2
#define SHADOW_FALLOFF AUX3.x
#define OUTER_WIDTH AUX3.y
#define OUTER_STRENGTH AUX3.z
#define OUTER_FALLOFF AUX3.w

float chamfer_effect_dist(float2 pos, float4 shape, float4 cuts)
{
	float2 shapeSize = max(shape.zw, float2(0.001, 0.001));
	return chamfer_dist_shape(pos - shape.xy, shapeSize, cuts);
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

	float shadowDist = chamfer_effect_dist(pos, SHADOW_SHAPE, SHADOW_CUTS);
	float shadowEffect =
		mgfx_css_shadow_effect(shadowDist, max(SHADOW_WIDTH, 0.001), max(SHADOW_FALLOFF, 0.001))
		* max(SHADOW_STRENGTH, 0.0);
	float4 shadowColor = float4(saturate(SHADOW_COLOR.rgb), saturate(SHADOW_COLOR.a * shadowEffect));

	float outerDist = chamfer_effect_dist(pos, OUTER_SHAPE, OUTER_CUTS);
	float outerEffect =
		mgfx_css_outer_effect(outerDist, max(OUTER_WIDTH, 0.001), max(OUTER_FALLOFF, 0.001))
		* max(OUTER_STRENGTH, 0.0);
	float4 outerColor = float4(saturate(OUTER_COLOR.rgb), saturate(OUTER_COLOR.a * outerEffect));

	float4 color = source_over(outerColor, shadowColor);
	clip(color.a - 0.001);
	return color;
}
