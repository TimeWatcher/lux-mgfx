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
	float2 texUV = lerp(FILL_PARAMS.xy, FILL_PARAMS.zw, saturate(i.uv));
	float4 texColor = tex2D(TexBase, texUV) * i.color;
	float texAlpha = texColor.a * fillMask;
	float strokeAlpha = STROKE_COLOR.a * borderMask;
	float alpha = texAlpha + strokeAlpha;
	clip(alpha - 0.001);

	float3 rgb = (texColor.rgb * texAlpha + STROKE_COLOR.rgb * strokeAlpha) / alpha;

	return float4(saturate(rgb), saturate(alpha));
}
