#ifndef MGFX_POLY_SHADOW_COMMON_HLSL
#define MGFX_POLY_SHADOW_COMMON_HLSL

#include "mgfx_poly_shape_common.hlsl"

#define SHADOW_COLOR AUX0
#define SHADOW_DRAW_SIZE AUX1.xy
#define SHADOW_WIDTH AUX1.z
#define SHADOW_FALLOFF AUX1.w
#define SHADOW_STRENGTH AUX2.x
#define SHADOW_GROW AUX2.y

float4 main(PS_INPUT i) : COLOR
{
	float2 p = i.uv * SHADOW_DRAW_SIZE;
	float dist = convex_poly_dist(p) - max(SHADOW_GROW, 0.0);
	float width = max(SHADOW_WIDTH, 0.001);
	float shadow = mgfx_css_shadow_effect(dist, width, max(SHADOW_FALLOFF, 0.001)) * max(SHADOW_STRENGTH, 0.0);
	float alpha = saturate(SHADOW_COLOR.a * shadow);

	clip(alpha - 0.001);
	return float4(saturate(SHADOW_COLOR.rgb), alpha);
}

#endif
