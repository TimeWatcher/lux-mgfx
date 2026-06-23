#include "mgfx_common.hlsl"
#include "mgfx_chamfer_common.hlsl"

#define DRAW_SIZE EXTRA0.xy
#define SHAPE_OFFSET EXTRA0.zw
#define SHAPE_SIZE EXTRA1.xy
#define CHAMFER_CUT_TL EXTRA1.z
#define CHAMFER_CUT_TR EXTRA1.w
#define CHAMFER_CUT_BR EXTRA2.x
#define CHAMFER_CUT_BL EXTRA2.y
#define GLOW_WIDTH EXTRA2.z
#define GLOW_FALLOFF EXTRA2.w
#define GLOW_STRENGTH EXTRA3.x

float4 main(PS_INPUT i) : COLOR
{
	float2 pos = i.uv * DRAW_SIZE;
	float2 shapeSize = max(SHAPE_SIZE, float2(0.001, 0.001));
	float4 cuts = float4(CHAMFER_CUT_TL, CHAMFER_CUT_TR, CHAMFER_CUT_BR, CHAMFER_CUT_BL);
	float dist = chamfer_dist_shape(pos - SHAPE_OFFSET, shapeSize, cuts);
	float width = max(GLOW_WIDTH, 0.001);
	float falloff = max(GLOW_FALLOFF, 0.001);
	float effect = mgfx_css_outer_effect(dist, width, falloff) * max(GLOW_STRENGTH, 0.0);
	float alpha = saturate(i.color.a * effect);

	clip(alpha - 0.001);
	return float4(saturate(i.color.rgb), alpha);
}
