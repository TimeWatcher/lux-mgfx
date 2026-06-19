#include "mgfx_roundrect_common.hlsl"

#define GLOW_COLOR EXTRA0
#define GLOW_WIDTH EXTRA2.x
#define GLOW_STRENGTH EXTRA2.y
#define GLOW_FALLOFF EXTRA2.z

float inner_glow_profile(float depth, float width, float falloff)
{
	float t = max(depth, 0.0) / max(width, 0.001);
	float decay = max(falloff, 0.001) * 1.55;
	return exp2(-pow(t, 1.35) * decay);
}

float4 main(PS_INPUT i) : COLOR
{
	float2 pos = i.uv * SIZE;
	float2 halfSize = SIZE * 0.5;
	float radius = min(SHAPE_RADIUS, min(halfSize.x, halfSize.y));
	float width = max(GLOW_WIDTH, 0.001);
	float falloff = max(GLOW_FALLOFF, 0.001);

	float outerDist = sd_roundrect(pos - halfSize, halfSize, radius);
	float shape = roundrect_coverage_from_dist(outerDist);
	float depth = max(-outerDist, 0.0);
	float glow = inner_glow_profile(depth, width, falloff) * shape * max(GLOW_STRENGTH, 0.0);
	float alpha = saturate(GLOW_COLOR.a * glow);

	clip(alpha - 0.001);
	return float4(saturate(GLOW_COLOR.rgb), alpha);
}
