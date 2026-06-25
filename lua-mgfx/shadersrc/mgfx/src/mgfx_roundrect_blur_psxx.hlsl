#include "mgfx_roundrect_common.hlsl"
#include "mgfx_blur_common.hlsl"

#define BACKDROP_TINT AUX0
#define BACKDROP_TINT_ENABLED AUX1.x

float4 source_over(float4 top, float4 bottom)
{
	float alpha = top.a + bottom.a * (1.0 - top.a);
	float3 rgb = (top.rgb * top.a + bottom.rgb * bottom.a * (1.0 - top.a)) / max(alpha, 0.0001);
	return float4(saturate(rgb), saturate(alpha));
}

float4 main(PS_INPUT i) : COLOR
{
	float alpha = roundrect_coverage(i.uv);
	clip(alpha - 0.001);

	float4 color = float4(mgfx_blur(i.pos * TexBaseSize), alpha);
	if (BACKDROP_TINT_ENABLED > 0.5 && BACKDROP_TINT.a > 0.0)
	{
		color = source_over(float4(saturate(BACKDROP_TINT.rgb), saturate(BACKDROP_TINT.a * alpha)), color);
	}

	return color;
}
