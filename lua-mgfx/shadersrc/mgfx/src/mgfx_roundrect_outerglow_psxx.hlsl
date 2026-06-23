#include "mgfx_common.hlsl"

#define GLOW_COLOR EXTRA0
#define DRAW_SIZE EXTRA1.xy
#define SHAPE_OFFSET EXTRA2.xy
#define SHAPE_SIZE EXTRA2.zw
#define GLOW_RADIUS EXTRA3.x
#define GLOW_WIDTH EXTRA3.y
#define GLOW_STRENGTH EXTRA3.z
#define GLOW_FALLOFF EXTRA3.w

float sd_roundrect(float2 p, float2 halfSize, float radius)
{
	float2 q = abs(p) - halfSize + radius;
	return min(max(q.x, q.y), 0.0) + length(max(q, 0.0)) - radius;
}

float4 main(PS_INPUT i) : COLOR
{
	float2 pos = i.uv * DRAW_SIZE;
	float2 halfSize = max(SHAPE_SIZE * 0.5, float2(0.001, 0.001));
	float radius = min(max(GLOW_RADIUS, 0.0), min(halfSize.x, halfSize.y));
	float dist = sd_roundrect(pos - SHAPE_OFFSET - halfSize, halfSize, radius);
	float width = max(GLOW_WIDTH, 0.001);
	float falloff = max(GLOW_FALLOFF, 0.001);
	float strength = max(GLOW_STRENGTH, 0.0);
	float effect = mgfx_css_outer_effect(dist, width, falloff) * strength;
	float alpha = saturate(GLOW_COLOR.a * effect);

	clip(alpha - 0.001);
	return float4(saturate(GLOW_COLOR.rgb), alpha);
}
