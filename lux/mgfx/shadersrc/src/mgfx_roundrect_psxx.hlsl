#include "mgfx_roundrect_common.hlsl"

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
	float alpha = fillAlpha + strokeAlpha;
	clip(alpha - 0.001);

	float3 rgb = (fillColor.rgb * fillAlpha + STROKE_COLOR.rgb * strokeAlpha) / alpha;

	return float4(saturate(rgb), saturate(alpha));
}
