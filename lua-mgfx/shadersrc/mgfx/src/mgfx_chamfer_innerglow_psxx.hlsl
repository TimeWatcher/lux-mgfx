#include "mgfx_common.hlsl"

#define GLOW_COLOR EXTRA0
#define CHAMFER_CUTS EXTRA2
#define GLOW_WIDTH EXTRA3.x
#define GLOW_STRENGTH EXTRA3.y
#define GLOW_FALLOFF EXTRA3.z

float inner_glow_profile(float depth, float width, float falloff)
{
	float t = max(depth, 0.0) / max(width, 0.001);
	float decay = max(falloff, 0.001) * 1.55;
	return exp2(-pow(t, 1.35) * decay);
}

#include "mgfx_chamfer_common.hlsl"

float4 main(PS_INPUT i) : COLOR
{
	float2 p = i.uv * SIZE;
	float width = max(GLOW_WIDTH, 0.001);
	float falloff = max(GLOW_FALLOFF, 0.001);

	float outerDist = chamfer_dist_shape(p, SIZE, CHAMFER_CUTS);
	float shape = aa_coverage(outerDist);
	float depth = max(-outerDist, 0.0);
	float glow = inner_glow_profile(depth, width, falloff) * shape * max(GLOW_STRENGTH, 0.0);
	float alpha = saturate(GLOW_COLOR.a * glow);

	clip(alpha - 0.001);
	return float4(saturate(GLOW_COLOR.rgb), alpha);
}
