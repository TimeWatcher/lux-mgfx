#ifndef MGFX_POLY_OUTERGLOW_COMMON_HLSL
#define MGFX_POLY_OUTERGLOW_COMMON_HLSL

#include "mgfx_poly_shape_common.hlsl"

#define GLOW_COLOR Constants0
#define GLOW_DRAW_SIZE Constants1.xy
#define GLOW_WIDTH Constants1.z
#define GLOW_FALLOFF Constants1.w
#define GLOW_STRENGTH Constants2.x
#define GLOW_GROW Constants2.y

float4 main(PS_INPUT i) : COLOR
{
	float2 p = i.uv * GLOW_DRAW_SIZE;
	float dist = convex_poly_dist(p) - max(GLOW_GROW, 0.0);
	float width = max(GLOW_WIDTH, 0.001);
	float glow = mgfx_css_outer_effect(dist, width, max(GLOW_FALLOFF, 0.001)) * max(GLOW_STRENGTH, 0.0);
	float alpha = saturate(GLOW_COLOR.a * glow);

	clip(alpha - 0.001);
	return float4(saturate(GLOW_COLOR.rgb), alpha);
}

#endif
