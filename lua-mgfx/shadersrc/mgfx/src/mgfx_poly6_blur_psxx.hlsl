#define MGFX_POLY_COUNT 6
#include "mgfx_poly_common.hlsl"
#include "mgfx_blur_common.hlsl"

float4 main(PS_INPUT i) : COLOR
{
	return float4(mgfx_blur(i.pos * TexBaseSize), 1.0);
}
