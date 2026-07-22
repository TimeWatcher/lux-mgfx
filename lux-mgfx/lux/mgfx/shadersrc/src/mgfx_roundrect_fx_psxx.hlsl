#include "mgfx_roundrect_common.hlsl"

#define INNER_GLOW_COLOR AUX0
#define INNER_GLOW_WIDTH AUX1.x
#define INNER_GLOW_STRENGTH AUX1.y
#define INNER_GLOW_FALLOFF AUX1.z

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

float4 source_over(float4 top, float4 bottom)
{
	float alpha = top.a + bottom.a * (1.0 - top.a);
	float3 rgb = (top.rgb * top.a + bottom.rgb * bottom.a * (1.0 - top.a)) / max(alpha, 0.0001);
	return float4(saturate(rgb), saturate(alpha));
}

float4 main(PS_INPUT i) : COLOR
{
	float dist = roundrect_dist(i.uv);
	float outer = roundrect_coverage_from_dist(dist);
	float borderMask = STROKE_COLOR.a > 0.0 ? roundrect_stroke_coverage_from_dist(dist, STROKE_WIDTH) : 0.0;
	float fillMask = outer * (1.0 - borderMask);
	float4 fillColor = mgfx_fill(i.uv, i.color, i.pos);
	float fillAlpha = fillColor.a * fillMask;
	float strokeAlpha = STROKE_COLOR.a * borderMask;
	float baseAlpha = fillAlpha + strokeAlpha;
	float3 baseRgb = (fillColor.rgb * fillAlpha + STROKE_COLOR.rgb * strokeAlpha) / max(baseAlpha, 0.0001);
	float4 baseColor = float4(saturate(baseRgb), saturate(baseAlpha));

	if (INNER_GLOW_COLOR.a > 0.0 && INNER_GLOW_WIDTH > 0.0 && INNER_GLOW_STRENGTH > 0.0)
	{
		float glow = roundrect_inner_glow(i.uv * SIZE, SIZE, INNER_GLOW_WIDTH, INNER_GLOW_FALLOFF) * outer * max(INNER_GLOW_STRENGTH, 0.0);
		float4 glowColor = float4(saturate(INNER_GLOW_COLOR.rgb), saturate(INNER_GLOW_COLOR.a * glow));
		baseColor = source_over(glowColor, baseColor);
	}

	clip(baseColor.a - 0.001);
	return baseColor;
}
