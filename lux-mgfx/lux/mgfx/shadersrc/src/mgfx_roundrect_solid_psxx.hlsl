#include "mgfx_roundrect_common.hlsl"

#define SOLID_COLOR EXTRA0

float4 main(PS_INPUT i) : COLOR
{
	float alpha = SOLID_COLOR.a * roundrect_coverage(i.uv);
	clip(alpha - 0.001);
	return float4(saturate(SOLID_COLOR.rgb), saturate(alpha));
}
