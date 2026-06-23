#ifndef MGFX_POLY_STROKE_COMMON_HLSL
#define MGFX_POLY_STROKE_COMMON_HLSL

#include "mgfx_poly_shape_common.hlsl"

#define POLY_STROKE_COLOR Constants0
#define POLY_STROKE_DRAW_SIZE Constants1.xy
#define POLY_STROKE_WIDTH Constants1.z

float4 main(PS_INPUT i) : COLOR
{
	float2 p = i.uv * POLY_STROKE_DRAW_SIZE;
	float alpha = saturate(POLY_STROKE_COLOR.a * poly_stroke_coverage(p, max(POLY_STROKE_WIDTH, 0.0)));

	clip(alpha - 0.001);
	return float4(saturate(POLY_STROKE_COLOR.rgb), alpha);
}

#endif
