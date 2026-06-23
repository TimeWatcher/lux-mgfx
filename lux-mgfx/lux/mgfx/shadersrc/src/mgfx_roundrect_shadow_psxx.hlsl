#include "mgfx_common.hlsl"

#define SHADOW_COLOR EXTRA0
#define DRAW_SIZE EXTRA1.xy
#define SHAPE_OFFSET EXTRA2.xy
#define SHAPE_SIZE EXTRA2.zw
#define SHADOW_RADIUS EXTRA3.x
#define SHADOW_WIDTH EXTRA3.y
#define SHADOW_STRENGTH EXTRA3.z
#define SHADOW_FALLOFF EXTRA3.w

float sd_roundrect(float2 p, float2 halfSize, float radius)
{
	float2 q = abs(p) - halfSize + radius;
	return min(max(q.x, q.y), 0.0) + length(max(q, 0.0)) - radius;
}

float4 main(PS_INPUT i) : COLOR
{
	float2 pos = i.uv * DRAW_SIZE;
	float2 halfSize = max(SHAPE_SIZE * 0.5, float2(0.001, 0.001));
	float radius = min(max(SHADOW_RADIUS, 0.0), min(halfSize.x, halfSize.y));
	float dist = sd_roundrect(pos - SHAPE_OFFSET - halfSize, halfSize, radius);
	float width = max(SHADOW_WIDTH, 0.001);
	float falloff = max(SHADOW_FALLOFF, 0.001);
	float effect = mgfx_css_shadow_effect(dist, width, falloff) * max(SHADOW_STRENGTH, 0.0);
	float alpha = saturate(SHADOW_COLOR.a * effect);

	clip(alpha - 0.001);
	return float4(saturate(SHADOW_COLOR.rgb), alpha);
}
