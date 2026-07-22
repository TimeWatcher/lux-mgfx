#include "mgfx_roundrect_common.hlsl"
#include "mgfx_stroke_pattern_common.hlsl"

#define STROKE_KIND EXTRA2.x
#define STROKE_DASH_LENGTH EXTRA2.y
#define STROKE_GAP EXTRA2.z
#define STROKE_OFFSET EXTRA2.w

float roundrect_path_coord(float2 p)
{
	float2 size = max(SIZE, float2(0.001, 0.001));
	float radius = min(max(SHAPE_RADIUS, 0.0), min(size.x, size.y) * 0.5);
	float bestDist = 100000.0;
	float bestCoord = 0.0;
	float prefix = 0.0;
	float halfPi = 1.57079632679;
	float pi = 3.14159265359;

	prefix = stroke_path_add_segment(p, float2(radius, 0.0), float2(size.x - radius, 0.0), prefix, bestDist, bestCoord);
	prefix = stroke_path_add_arc(p, float2(size.x - radius, radius), radius, pi * 1.5, pi * 2.0, prefix, bestDist, bestCoord);
	prefix = stroke_path_add_segment(p, float2(size.x, radius), float2(size.x, size.y - radius), prefix, bestDist, bestCoord);
	prefix = stroke_path_add_arc(p, float2(size.x - radius, size.y - radius), radius, 0.0, halfPi, prefix, bestDist, bestCoord);
	prefix = stroke_path_add_segment(p, float2(size.x - radius, size.y), float2(radius, size.y), prefix, bestDist, bestCoord);
	prefix = stroke_path_add_arc(p, float2(radius, size.y - radius), radius, halfPi, pi, prefix, bestDist, bestCoord);
	prefix = stroke_path_add_segment(p, float2(0.0, size.y - radius), float2(0.0, radius), prefix, bestDist, bestCoord);
	stroke_path_add_arc(p, float2(radius, radius), radius, pi, pi * 1.5, prefix, bestDist, bestCoord);
	return bestCoord;
}

float4 main(PS_INPUT i) : COLOR
{
	float4 strokeColor = EXTRA0;
	float2 pos = i.uv * SIZE;
	float dist = roundrect_dist_px(pos);
	float width = max(STROKE_WIDTH, 0.0);
	float stroke = roundrect_stroke_coverage_from_dist(dist, width);
	float pattern = stroke_pattern_mask(roundrect_path_coord(pos), dist, width, STROKE_KIND, STROKE_DASH_LENGTH, STROKE_GAP, STROKE_OFFSET);
	float alpha = strokeColor.a * stroke * pattern;
	clip(alpha - 0.001);

	return float4(saturate(strokeColor.rgb), saturate(alpha));
}
