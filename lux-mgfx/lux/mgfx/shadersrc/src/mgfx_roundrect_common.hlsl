#ifndef MGFX_ROUNDRECT_COMMON_HLSL
#define MGFX_ROUNDRECT_COMMON_HLSL

#include "mgfx_common.hlsl"

float sd_roundrect(float2 p, float2 halfSize, float radius)
{
	float2 q = abs(p) - halfSize + radius;
	return min(max(q.x, q.y), 0.0) + length(max(q, 0.0)) - radius;
}

float roundrect_dist_px(float2 screenPos)
{
	float2 p = screenPos - SIZE * 0.5;
	return sd_roundrect(p, SIZE * 0.5, SHAPE_RADIUS);
}

float roundrect_dist(float2 uv)
{
	return roundrect_dist_px(uv * SIZE);
}

float roundrect_coverage_from_dist(float dist)
{
	return aa_coverage(dist);
}

float roundrect_coverage(float2 uv)
{
	float2 screenPos = uv * SIZE;
	return roundrect_coverage_from_dist(roundrect_dist_px(screenPos));
}

#endif
