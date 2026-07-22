const float4x4 MGFXExtraParams : register(c11);

#define EXTRA0 MGFXExtraParams[0]
#define EXTRA1 MGFXExtraParams[1]
#define EXTRA2 MGFXExtraParams[2]
#define EXTRA3 MGFXExtraParams[3]

#define STROKE_COLOR EXTRA0
#define SHAPE_SIZE EXTRA1.xy
#define STROKE_WIDTH EXTRA1.z
#define STROKE_KIND EXTRA1.w
#define CHAMFER_CUTS EXTRA2
#define STROKE_DASH_LENGTH EXTRA3.x
#define STROKE_GAP EXTRA3.y
#define STROKE_OFFSET EXTRA3.z

struct PS_INPUT
{
	float2 uv    : TEXCOORD0;
	float4 color : TEXCOORD1;
	float2 pos   : VPOS;
};

#include "mgfx_chamfer_common.hlsl"
#include "mgfx_stroke_pattern_common.hlsl"

float chamfer_path_coord(float2 p, float2 size, float4 cuts)
{
	float limit = min(size.x, size.y) * 0.5;
	float tl = min(cuts.x, limit);
	float tr = min(cuts.y, limit);
	float br = min(cuts.z, limit);
	float bl = min(cuts.w, limit);
	float2 p0 = float2(tl, 0.0);
	float2 p1 = float2(size.x - tr, 0.0);
	float2 p2 = float2(size.x, tr);
	float2 p3 = float2(size.x, size.y - br);
	float2 p4 = float2(size.x - br, size.y);
	float2 p5 = float2(bl, size.y);
	float2 p6 = float2(0.0, size.y - bl);
	float2 p7 = float2(0.0, tl);
	float bestDist = 100000.0;
	float bestCoord = 0.0;
	float prefix = 0.0;
	prefix = stroke_path_add_segment(p, p0, p1, prefix, bestDist, bestCoord);
	prefix = stroke_path_add_segment(p, p1, p2, prefix, bestDist, bestCoord);
	prefix = stroke_path_add_segment(p, p2, p3, prefix, bestDist, bestCoord);
	prefix = stroke_path_add_segment(p, p3, p4, prefix, bestDist, bestCoord);
	prefix = stroke_path_add_segment(p, p4, p5, prefix, bestDist, bestCoord);
	prefix = stroke_path_add_segment(p, p5, p6, prefix, bestDist, bestCoord);
	prefix = stroke_path_add_segment(p, p6, p7, prefix, bestDist, bestCoord);
	stroke_path_add_segment(p, p7, p0, prefix, bestDist, bestCoord);
	return bestCoord;
}

float4 main(PS_INPUT i) : COLOR
{
	float2 size = max(SHAPE_SIZE, float2(0.001, 0.001));
	float2 pos = i.uv * size;
	float dist = chamfer_dist_shape(pos, size, CHAMFER_CUTS);
	float edgeDist = abs(dist);
	float width = max(STROKE_WIDTH, 0.0);
	float aa = max(fwidth(edgeDist), 1.0);
	float stroke = 1.0 - smoothstep(width * 0.5 - aa, width * 0.5 + aa, edgeDist);
	float pattern = stroke_pattern_mask(chamfer_path_coord(pos, size, CHAMFER_CUTS), dist, width, STROKE_KIND, STROKE_DASH_LENGTH, STROKE_GAP, STROKE_OFFSET);
	float alpha = STROKE_COLOR.a * stroke * pattern;
	clip(alpha - 0.001);

	return float4(saturate(STROKE_COLOR.rgb), saturate(alpha));
}
