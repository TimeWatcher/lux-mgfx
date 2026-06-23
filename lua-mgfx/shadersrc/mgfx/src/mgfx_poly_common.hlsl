#ifndef MGFX_POLY_COMMON_HLSL
#define MGFX_POLY_COMMON_HLSL

#include "mgfx_poly_shape_common.hlsl"

float4 mgfx_poly_fill(float2 uv, float4 baseColor)
{
	float2 shapeSize = max(SIZE, float2(0.001, 0.001));
	float2 p = uv * shapeSize;
	float fillMask = poly_shape_coverage(p);
	if (fillMask <= 0.001)
		discard;

	float4 fillColor = mgfx_fill(uv, baseColor);
	float alpha = fillColor.a * fillMask;
	if (alpha <= 0.001)
		discard;

	return float4(saturate(fillColor.rgb), saturate(alpha));
}

#endif
