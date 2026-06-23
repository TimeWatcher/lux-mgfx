#include "mgfx_common.hlsl"
#define BLUR_VERTICAL EXTRA3.x
#define BLUR_INTENSITY EXTRA3.y
#include "mgfx_blur_common.hlsl"
#include "mgfx_chamfer_common.hlsl"

#define DRAW_SIZE EXTRA0.xy
#define SHAPE_OFFSET EXTRA0.zw
#define SHAPE_SIZE EXTRA1.xy
#define CHAMFER_CUT_TL EXTRA1.z
#define CHAMFER_CUT_TR EXTRA1.w
#define CHAMFER_CUT_BR EXTRA2.x
#define CHAMFER_CUT_BL EXTRA2.y

float4 main(PS_INPUT i) : COLOR
{
	float2 pos = i.uv * DRAW_SIZE;
	float2 shapeSize = max(SHAPE_SIZE, float2(0.001, 0.001));
	float4 cuts = float4(CHAMFER_CUT_TL, CHAMFER_CUT_TR, CHAMFER_CUT_BR, CHAMFER_CUT_BL);
	float alpha = aa_coverage(chamfer_dist_shape(pos - SHAPE_OFFSET, shapeSize, cuts));
	clip(alpha - 0.001);
	return float4(mgfx_blur(i.pos * TexBaseSize) * i.color.rgb, alpha * i.color.a);
}
