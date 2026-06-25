#ifndef MGFX_POLY_SHAPE_COMMON_HLSL
#define MGFX_POLY_SHAPE_COMMON_HLSL

#include "mgfx_common.hlsl"

#ifndef MGFX_POLY_COUNT
#define MGFX_POLY_COUNT 3
#endif

#if MGFX_POLY_VERTS_FROM_CONSTANTS
#define POLY_V0 AUX0.xy
#define POLY_V1 AUX0.zw
#define POLY_V2 AUX1.xy
#define POLY_V3 AUX1.zw
#define POLY_V4 AUX2.xy
#define POLY_V5 AUX2.zw
#define POLY_V6 AUX3.xy
#define POLY_V7 AUX3.zw
#else
#define POLY_V0 EXTRA0.xy
#define POLY_V1 EXTRA0.zw
#define POLY_V2 EXTRA1.xy
#define POLY_V3 EXTRA1.zw
#define POLY_V4 EXTRA2.xy
#define POLY_V5 EXTRA2.zw
#define POLY_V6 EXTRA3.xy
#define POLY_V7 EXTRA3.zw
#endif

float cross2(float2 a, float2 b)
{
	return a.x * b.y - a.y * b.x;
}

float segment_dist(float2 p, float2 a, float2 b)
{
	float2 ab = b - a;
	float t = saturate(dot(p - a, ab) / max(dot(ab, ab), 0.0001));
	return length(p - (a + ab * t));
}

void add_edge(float2 p, float2 a, float2 b, inout float maxOutside, inout float minSegment)
{
	float2 ab = b - a;
	float inside = cross2(ab, p - a) / max(length(ab), 0.0001);
	maxOutside = max(maxOutside, -inside);
	minSegment = min(minSegment, segment_dist(p, a, b));
}

float convex_poly_dist(float2 p)
{
	float maxOutside = -100000.0;
	float minSegment = 100000.0;

#if MGFX_POLY_COUNT == 3
	add_edge(p, POLY_V0, POLY_V1, maxOutside, minSegment);
	add_edge(p, POLY_V1, POLY_V2, maxOutside, minSegment);
	add_edge(p, POLY_V2, POLY_V0, maxOutside, minSegment);
#elif MGFX_POLY_COUNT == 4
	add_edge(p, POLY_V0, POLY_V1, maxOutside, minSegment);
	add_edge(p, POLY_V1, POLY_V2, maxOutside, minSegment);
	add_edge(p, POLY_V2, POLY_V3, maxOutside, minSegment);
	add_edge(p, POLY_V3, POLY_V0, maxOutside, minSegment);
#elif MGFX_POLY_COUNT == 5
	add_edge(p, POLY_V0, POLY_V1, maxOutside, minSegment);
	add_edge(p, POLY_V1, POLY_V2, maxOutside, minSegment);
	add_edge(p, POLY_V2, POLY_V3, maxOutside, minSegment);
	add_edge(p, POLY_V3, POLY_V4, maxOutside, minSegment);
	add_edge(p, POLY_V4, POLY_V0, maxOutside, minSegment);
#elif MGFX_POLY_COUNT == 6
	add_edge(p, POLY_V0, POLY_V1, maxOutside, minSegment);
	add_edge(p, POLY_V1, POLY_V2, maxOutside, minSegment);
	add_edge(p, POLY_V2, POLY_V3, maxOutside, minSegment);
	add_edge(p, POLY_V3, POLY_V4, maxOutside, minSegment);
	add_edge(p, POLY_V4, POLY_V5, maxOutside, minSegment);
	add_edge(p, POLY_V5, POLY_V0, maxOutside, minSegment);
#elif MGFX_POLY_COUNT == 7
	add_edge(p, POLY_V0, POLY_V1, maxOutside, minSegment);
	add_edge(p, POLY_V1, POLY_V2, maxOutside, minSegment);
	add_edge(p, POLY_V2, POLY_V3, maxOutside, minSegment);
	add_edge(p, POLY_V3, POLY_V4, maxOutside, minSegment);
	add_edge(p, POLY_V4, POLY_V5, maxOutside, minSegment);
	add_edge(p, POLY_V5, POLY_V6, maxOutside, minSegment);
	add_edge(p, POLY_V6, POLY_V0, maxOutside, minSegment);
#else
	add_edge(p, POLY_V0, POLY_V1, maxOutside, minSegment);
	add_edge(p, POLY_V1, POLY_V2, maxOutside, minSegment);
	add_edge(p, POLY_V2, POLY_V3, maxOutside, minSegment);
	add_edge(p, POLY_V3, POLY_V4, maxOutside, minSegment);
	add_edge(p, POLY_V4, POLY_V5, maxOutside, minSegment);
	add_edge(p, POLY_V5, POLY_V6, maxOutside, minSegment);
	add_edge(p, POLY_V6, POLY_V7, maxOutside, minSegment);
	add_edge(p, POLY_V7, POLY_V0, maxOutside, minSegment);
#endif

	return maxOutside <= 0.0 ? maxOutside : minSegment;
}

float poly_coverage_width(float2 p)
{
	float2 dx = ddx(p);
	float2 dy = ddy(p);
	return max(max(length(dx), length(dy)), 1.0) * 1.35;
}

float poly_coverage_from_dist(float dist, float width)
{
	return smoothstep(0.5 * width, -0.5 * width, dist);
}

float poly_shape_coverage_at(float2 p, float width)
{
	return poly_coverage_from_dist(convex_poly_dist(p), width);
}

float poly_shape_coverage(float2 p)
{
	float2 dx = ddx(p) * 0.375;
	float2 dy = ddy(p) * 0.375;
	float width = poly_coverage_width(p);
	return (
		poly_shape_coverage_at(p - dx - dy * 0.333333, width) +
		poly_shape_coverage_at(p + dx * 0.333333 - dy, width) +
		poly_shape_coverage_at(p + dx + dy * 0.333333, width) +
		poly_shape_coverage_at(p - dx * 0.333333 + dy, width) +
		poly_shape_coverage_at(p - dx * 0.333333 - dy, width) +
		poly_shape_coverage_at(p + dx - dy * 0.333333, width) +
		poly_shape_coverage_at(p + dx * 0.333333 + dy, width) +
		poly_shape_coverage_at(p - dx + dy * 0.333333, width)
	) * 0.125;
}

float poly_stroke_coverage_at(float2 p, float strokeWidth, float coverageWidth)
{
	float dist = convex_poly_dist(p);
	float outer = poly_coverage_from_dist(dist, coverageWidth);
	float inner = poly_coverage_from_dist(dist + strokeWidth, coverageWidth);
	return outer * (1.0 - inner);
}

float poly_stroke_coverage(float2 p, float strokeWidth)
{
	float2 dx = ddx(p) * 0.375;
	float2 dy = ddy(p) * 0.375;
	float coverageWidth = poly_coverage_width(p);
	return (
		poly_stroke_coverage_at(p - dx - dy * 0.333333, strokeWidth, coverageWidth) +
		poly_stroke_coverage_at(p + dx * 0.333333 - dy, strokeWidth, coverageWidth) +
		poly_stroke_coverage_at(p + dx + dy * 0.333333, strokeWidth, coverageWidth) +
		poly_stroke_coverage_at(p - dx * 0.333333 + dy, strokeWidth, coverageWidth) +
		poly_stroke_coverage_at(p - dx * 0.333333 - dy, strokeWidth, coverageWidth) +
		poly_stroke_coverage_at(p + dx - dy * 0.333333, strokeWidth, coverageWidth) +
		poly_stroke_coverage_at(p + dx * 0.333333 + dy, strokeWidth, coverageWidth) +
		poly_stroke_coverage_at(p - dx + dy * 0.333333, strokeWidth, coverageWidth)
	) * 0.125;
}

#endif
