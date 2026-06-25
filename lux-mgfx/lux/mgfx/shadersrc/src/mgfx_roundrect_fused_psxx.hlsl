#include "mgfx_roundrect_common.hlsl"

#define SHADOW_COLOR AUX0
#define SHADOW_SPEC AUX1
#define OUTER_COLOR AUX2
#define EFFECT_SPEC AUX3

#define SHADOW_OFFSET SHADOW_SPEC.xy
#define SHADOW_GROW SHADOW_SPEC.z
#define SHADOW_WIDTH SHADOW_SPEC.w
#define SHADOW_FALLOFF EFFECT_SPEC.x
#define OUTER_GROW EFFECT_SPEC.y
#define OUTER_WIDTH EFFECT_SPEC.z
#define OUTER_FALLOFF EFFECT_SPEC.w

float shape_dist_px(float2 pos, float2 origin, float2 size, float radius)
{
	float2 halfSize = max(size, float2(0.001, 0.001)) * 0.5;
	float r = min(max(radius, 0.0), min(halfSize.x, halfSize.y));
	return sd_roundrect(pos - origin - halfSize, halfSize, r);
}

float4 source_over(float4 top, float4 bottom)
{
	float alpha = top.a + bottom.a * (1.0 - top.a);
	float3 rgb = (top.rgb * top.a + bottom.rgb * bottom.a * (1.0 - top.a)) / max(alpha, 0.0001);
	return float4(saturate(rgb), saturate(alpha));
}

float4 base_layer(float2 pos, float2 uv)
{
	float dist = roundrect_dist_px(pos);
	float outer = roundrect_coverage_from_dist(dist);

	float inner = 1.0;
	if (STROKE_WIDTH > 0.0 && STROKE_COLOR.a > 0.0)
		inner = roundrect_coverage_from_dist(dist + STROKE_WIDTH);

	float borderMask = outer * (1.0 - inner);
	float fillMask = outer * inner;
	float4 fillColor = mgfx_fill(uv, float4(1.0, 1.0, 1.0, 1.0));
	float fillAlpha = fillColor.a * fillMask;
	float strokeAlpha = STROKE_COLOR.a * borderMask;
	float baseAlpha = fillAlpha + strokeAlpha;
	float3 baseRgb = (fillColor.rgb * fillAlpha + STROKE_COLOR.rgb * strokeAlpha) / max(baseAlpha, 0.0001);
	return float4(saturate(baseRgb), saturate(baseAlpha));
}

float4 shadow_layer(float2 pos)
{
	float grow = max(SHADOW_GROW, 0.0);
	float2 size = SIZE + grow * 2.0;
	float2 origin = SHADOW_OFFSET - grow;
	float dist = shape_dist_px(pos, origin, size, SHAPE_RADIUS + grow);
	float effect = mgfx_css_shadow_effect(dist, max(SHADOW_WIDTH, 0.001), max(SHADOW_FALLOFF, 0.001));
	return float4(saturate(SHADOW_COLOR.rgb), saturate(SHADOW_COLOR.a * effect));
}

float4 outer_layer(float2 pos)
{
	float grow = max(OUTER_GROW, 0.0);
	float2 size = SIZE + grow * 2.0;
	float2 origin = -grow;
	float dist = shape_dist_px(pos, origin, size, SHAPE_RADIUS + grow);
	float effect = mgfx_css_outer_effect(dist, max(OUTER_WIDTH, 0.001), max(OUTER_FALLOFF, 0.001));
	return float4(saturate(OUTER_COLOR.rgb), saturate(OUTER_COLOR.a * effect));
}

float4 main(PS_INPUT i) : COLOR
{
	float2 uv = i.uv;
	float2 pos = uv * SIZE;

	float4 color = shadow_layer(pos);
	color = source_over(outer_layer(pos), color);
	color = source_over(base_layer(pos, uv), color);

	clip(color.a - 0.001);
	return color;
}
