#include "mgfx_common.hlsl"

#define TINT_COLOR EXTRA0
#define SHAPE_SIZE EXTRA1.xy
#define TEX_UV EXTRA2
#define CHAMFER_CUTS EXTRA3

#include "mgfx_chamfer_common.hlsl"

float4 main(PS_INPUT i) : COLOR
{
	float2 p = i.uv * SHAPE_SIZE;
	float dist = chamfer_dist_shape(p, SHAPE_SIZE, CHAMFER_CUTS);
	float shape = aa_coverage(dist);
	float2 texUV = lerp(TEX_UV.xy, TEX_UV.zw, saturate(i.uv));
	float4 texColor = tex2D(TexBase, texUV) * TINT_COLOR;
	float alpha = texColor.a * shape;
	clip(alpha - 0.001);
	return float4(saturate(texColor.rgb), saturate(alpha));
}
