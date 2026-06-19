#include "mgfx_roundrect_common.hlsl"

float4 main(PS_INPUT i) : COLOR
{
	float4 strokeColor = EXTRA0;
	float dist = roundrect_dist(i.uv);
	float outer = roundrect_coverage_from_dist(dist);
	float inner = roundrect_coverage_from_dist(dist + max(STROKE_WIDTH, 0.0));
	float alpha = strokeColor.a * outer * (1.0 - inner);
	clip(alpha - 0.001);

	return float4(saturate(strokeColor.rgb), saturate(alpha));
}
