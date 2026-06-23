#define MGFX_POLY_COUNT 8
#define MGFX_POLY_VERTS_FROM_CONSTANTS 1
#include "mgfx_poly_common.hlsl"

float4 main(PS_INPUT i) : COLOR
{
	return mgfx_poly_fill(i.uv, i.color);
}
