#define MGFX_POLY_COUNT 6
#include "mgfx_poly_common.hlsl"

float4 main(PS_INPUT i) : COLOR
{
	return mgfx_fill(i.uv, i.color);
}
