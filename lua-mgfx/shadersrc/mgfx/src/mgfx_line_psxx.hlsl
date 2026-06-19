#include "mgfx_common.hlsl"

#define LINE_COLOR_A Constants0
#define LINE_COLOR_B Constants1

float4 main(PS_INPUT i) : COLOR
{
	float4 color = mgfx_gradient_lut(i.uv.x);
	float noCaps = step(4.0, i.uv.y);
	float crossUv = i.uv.y - noCaps * 8.0;
	float widthEdge = abs(crossUv - 0.5) - 0.5;
	float capEdge = max(-i.uv.x, i.uv.x - 1.0);
	float widthAa = max(fwidth(crossUv), 0.001);
	float capAa = max(fwidth(i.uv.x), 0.001);
	float coverage = smoothstep(widthAa, -widthAa, widthEdge);
	coverage *= lerp(smoothstep(capAa, -capAa, capEdge), 1.0, noCaps);
	float alpha = color.a * coverage;
	clip(alpha - 0.001);
	return float4(saturate(color.rgb), saturate(alpha));
}
