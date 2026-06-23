#ifndef MGFX_POLY_SHADOW_COMMON_HLSL
#define MGFX_POLY_SHADOW_COMMON_HLSL

#include "mgfx_poly_shape_common.hlsl"

#define SHADOW_COLOR Constants0
#define SHADOW_DRAW_SIZE Constants1.xy
#define SHADOW_WIDTH Constants1.z
#define SHADOW_FALLOFF Constants1.w
#define SHADOW_STRENGTH Constants2.x
#define SHADOW_GROW Constants2.y

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
