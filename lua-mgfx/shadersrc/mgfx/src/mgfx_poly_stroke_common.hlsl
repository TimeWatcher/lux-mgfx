#ifndef MGFX_POLY_STROKE_COMMON_HLSL
#define MGFX_POLY_STROKE_COMMON_HLSL

#include "mgfx_poly_shape_common.hlsl"
#include "mgfx_stroke_pattern_common.hlsl"

#define POLY_STROKE_COLOR AUX0
#define POLY_STROKE_DRAW_SIZE AUX1.xy
#define POLY_STROKE_WIDTH AUX1.z
#define POLY_STROKE_KIND AUX1.w
#define POLY_STROKE_DASH_LENGTH AUX2.x
#define POLY_STROKE_GAP AUX2.y
#define POLY_STROKE_OFFSET AUX2.z

float2 poly_path_coord(float2 p)
{
	float bestDist = 100000.0;
	float bestCoord = 0.0;
	float prefix = 0.0;
#if MGFX_POLY_COUNT == 3
	prefix = stroke_path_add_segment(p, POLY_V0, POLY_V1, prefix, bestDist, bestCoord);
	prefix = stroke_path_add_segment(p, POLY_V1, POLY_V2, prefix, bestDist, bestCoord);
	prefix = stroke_path_add_segment(p, POLY_V2, POLY_V0, prefix, bestDist, bestCoord);
#elif MGFX_POLY_COUNT == 4
	prefix = stroke_path_add_segment(p, POLY_V0, POLY_V1, prefix, bestDist, bestCoord);
	prefix = stroke_path_add_segment(p, POLY_V1, POLY_V2, prefix, bestDist, bestCoord);
	prefix = stroke_path_add_segment(p, POLY_V2, POLY_V3, prefix, bestDist, bestCoord);
	prefix = stroke_path_add_segment(p, POLY_V3, POLY_V0, prefix, bestDist, bestCoord);
#elif MGFX_POLY_COUNT == 5
	prefix = stroke_path_add_segment(p, POLY_V0, POLY_V1, prefix, bestDist, bestCoord);
	prefix = stroke_path_add_segment(p, POLY_V1, POLY_V2, prefix, bestDist, bestCoord);
	prefix = stroke_path_add_segment(p, POLY_V2, POLY_V3, prefix, bestDist, bestCoord);
	prefix = stroke_path_add_segment(p, POLY_V3, POLY_V4, prefix, bestDist, bestCoord);
	prefix = stroke_path_add_segment(p, POLY_V4, POLY_V0, prefix, bestDist, bestCoord);
#elif MGFX_POLY_COUNT == 6
	prefix = stroke_path_add_segment(p, POLY_V0, POLY_V1, prefix, bestDist, bestCoord);
	prefix = stroke_path_add_segment(p, POLY_V1, POLY_V2, prefix, bestDist, bestCoord);
	prefix = stroke_path_add_segment(p, POLY_V2, POLY_V3, prefix, bestDist, bestCoord);
	prefix = stroke_path_add_segment(p, POLY_V3, POLY_V4, prefix, bestDist, bestCoord);
	prefix = stroke_path_add_segment(p, POLY_V4, POLY_V5, prefix, bestDist, bestCoord);
	prefix = stroke_path_add_segment(p, POLY_V5, POLY_V0, prefix, bestDist, bestCoord);
#elif MGFX_POLY_COUNT == 7
	prefix = stroke_path_add_segment(p, POLY_V0, POLY_V1, prefix, bestDist, bestCoord);
	prefix = stroke_path_add_segment(p, POLY_V1, POLY_V2, prefix, bestDist, bestCoord);
	prefix = stroke_path_add_segment(p, POLY_V2, POLY_V3, prefix, bestDist, bestCoord);
	prefix = stroke_path_add_segment(p, POLY_V3, POLY_V4, prefix, bestDist, bestCoord);
	prefix = stroke_path_add_segment(p, POLY_V4, POLY_V5, prefix, bestDist, bestCoord);
	prefix = stroke_path_add_segment(p, POLY_V5, POLY_V6, prefix, bestDist, bestCoord);
	prefix = stroke_path_add_segment(p, POLY_V6, POLY_V0, prefix, bestDist, bestCoord);
#else
	prefix = stroke_path_add_segment(p, POLY_V0, POLY_V1, prefix, bestDist, bestCoord);
	prefix = stroke_path_add_segment(p, POLY_V1, POLY_V2, prefix, bestDist, bestCoord);
	prefix = stroke_path_add_segment(p, POLY_V2, POLY_V3, prefix, bestDist, bestCoord);
	prefix = stroke_path_add_segment(p, POLY_V3, POLY_V4, prefix, bestDist, bestCoord);
	prefix = stroke_path_add_segment(p, POLY_V4, POLY_V5, prefix, bestDist, bestCoord);
	prefix = stroke_path_add_segment(p, POLY_V5, POLY_V6, prefix, bestDist, bestCoord);
	prefix = stroke_path_add_segment(p, POLY_V6, POLY_V7, prefix, bestDist, bestCoord);
	prefix = stroke_path_add_segment(p, POLY_V7, POLY_V0, prefix, bestDist, bestCoord);
#endif
	return float2(bestCoord, prefix);
}

float4 main(PS_INPUT i) : COLOR
{
	float2 p = i.uv * POLY_STROKE_DRAW_SIZE;
	float width = max(POLY_STROKE_WIDTH, 0.0);
	float dist = convex_poly_dist(p);
	float2 path = poly_path_coord(p);
	float pattern = stroke_pattern_mask(path.x, path.y, dist, width, POLY_STROKE_KIND, POLY_STROKE_DASH_LENGTH, POLY_STROKE_GAP, POLY_STROKE_OFFSET);
	float alpha = saturate(POLY_STROKE_COLOR.a * poly_stroke_coverage(p, width) * pattern);

	clip(alpha - 0.001);
	return float4(saturate(POLY_STROKE_COLOR.rgb), alpha);
}

#endif
