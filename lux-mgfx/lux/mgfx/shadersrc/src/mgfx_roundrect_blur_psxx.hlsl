#include "mgfx_roundrect_common.hlsl"
#include "mgfx_blur_common.hlsl"

float4 main(PS_INPUT i) : COLOR
{
	float alpha = roundrect_coverage(i.uv);
	clip(alpha - 0.001);

	return float4(mgfx_blur(i.pos * TexBaseSize), alpha);
}
