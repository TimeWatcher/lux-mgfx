#include "mgfx_roundrect_common.hlsl"

#define INNER_GLOW_COLOR Constants0
#define INNER_GLOW_WIDTH Constants1.x
#define INNER_GLOW_STRENGTH Constants1.y
#define INNER_GLOW_FALLOFF Constants1.z

float inner_glow_profile(float depth, float width, float falloff)
{
	float t = max(depth, 0.0) / max(width, 0.001);
	float decay = max(falloff, 0.001) * 1.55;
	return exp2(-pow(t, 1.35) * decay);
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

	float inner = 1.0;
	if (STROKE_WIDTH > 0.0 && STROKE_COLOR.a > 0.0)
		inner = roundrect_coverage_from_dist(dist + STROKE_WIDTH);

	float borderMask = outer * (1.0 - inner);
	float fillMask = outer * inner;
	float4 fillColor = mgfx_fill(i.uv, i.color);
	float fillAlpha = fillColor.a * fillMask;
	float strokeAlpha = STROKE_COLOR.a * borderMask;
	float baseAlpha = fillAlpha + strokeAlpha;
	float3 baseRgb = (fillColor.rgb * fillAlpha + STROKE_COLOR.rgb * strokeAlpha) / max(baseAlpha, 0.0001);
	float4 baseColor = float4(saturate(baseRgb), saturate(baseAlpha));

	if (INNER_GLOW_COLOR.a > 0.0 && INNER_GLOW_WIDTH > 0.0 && INNER_GLOW_STRENGTH > 0.0)
	{
		float depth = max(-dist, 0.0);
		float glow = inner_glow_profile(depth, INNER_GLOW_WIDTH, INNER_GLOW_FALLOFF) * outer * max(INNER_GLOW_STRENGTH, 0.0);
		float4 glowColor = float4(saturate(INNER_GLOW_COLOR.rgb), saturate(INNER_GLOW_COLOR.a * glow));
		baseColor = source_over(glowColor, baseColor);
	}

	clip(baseColor.a - 0.001);
	return baseColor;
}
