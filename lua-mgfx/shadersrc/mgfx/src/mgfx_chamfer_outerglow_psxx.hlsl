#include "mgfx_common.hlsl"

#define GLOW_COLOR EXTRA0
#define DRAW_SIZE EXTRA1.xy
#define SHAPE_OFFSET EXTRA1.zw
#define CHAMFER_CUTS EXTRA2
#define GLOW_WIDTH EXTRA3.x
#define GLOW_STRENGTH EXTRA3.y
#define GLOW_FALLOFF EXTRA3.z

#include "mgfx_chamfer_common.hlsl"

float4 main(PS_INPUT i) : COLOR
{
	float2 pos = i.uv * DRAW_SIZE;
	float2 shapeSize = max(DRAW_SIZE - SHAPE_OFFSET * 2.0, float2(0.001, 0.001));
	float dist = chamfer_dist_shape(pos - SHAPE_OFFSET, shapeSize, CHAMFER_CUTS);
	float outside = max(dist, 0.0);
	float width = max(GLOW_WIDTH, 0.001);
	float falloff = max(GLOW_FALLOFF, 0.001);

	float outsideMask = 1.0 - aa_coverage(dist);
	float edge = 1.0 - smoothstep(0.0, width, outside);
	float glow = pow(saturate(edge), falloff) * outsideMask * max(GLOW_STRENGTH, 0.0);
	float alpha = saturate(GLOW_COLOR.a * glow);

	clip(alpha - 0.001);
	return float4(saturate(GLOW_COLOR.rgb), alpha);
}
