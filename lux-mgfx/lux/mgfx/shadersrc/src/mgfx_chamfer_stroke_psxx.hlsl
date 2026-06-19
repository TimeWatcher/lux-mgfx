const float4x4 MGFXExtraParams : register(c11);

#define EXTRA0 MGFXExtraParams[0]
#define EXTRA1 MGFXExtraParams[1]
#define EXTRA2 MGFXExtraParams[2]

#define STROKE_COLOR EXTRA0
#define SHAPE_SIZE EXTRA1.xy
#define STROKE_WIDTH EXTRA1.z
#define CHAMFER_CUTS EXTRA2

struct PS_INPUT
{
	float2 uv    : TEXCOORD0;
	float4 color : TEXCOORD1;
	float2 pos   : VPOS;
};

#include "mgfx_chamfer_common.hlsl"

float4 main(PS_INPUT i) : COLOR
{
	float2 size = max(SHAPE_SIZE, float2(0.001, 0.001));
	float2 pos = i.uv * size;
	float dist = chamfer_dist_shape(pos, size, CHAMFER_CUTS);
	float edgeDist = abs(dist);
	float width = max(STROKE_WIDTH, 0.0);
	float aa = max(fwidth(edgeDist), 1.0);
	float alpha = STROKE_COLOR.a * (1.0 - smoothstep(width - aa, width + aa, edgeDist));
	clip(alpha - 0.001);

	return float4(saturate(STROKE_COLOR.rgb), saturate(alpha));
}
