#ifndef MGFX_STROKE_PATTERN_COMMON_HLSL
#define MGFX_STROKE_PATTERN_COMMON_HLSL

#define MGFX_STROKE_SOLID 0.0
#define MGFX_STROKE_DOT 1.0
#define MGFX_STROKE_DASH 2.0
#define MGFX_STROKE_DOT_DASH 3.0

float stroke_pattern_coverage_from_dist(float dist)
{
	float aa = max(fwidth(dist), 0.75);
	return smoothstep(aa, -aa, dist);
}

float stroke_cycle_distance(float value, float center, float period)
{
	float d = abs(value - center);
	return min(d, period - d);
}

float stroke_capsule_pattern_dist(float along, float normal, float visibleLength, float halfWidth)
{
	float halfStraight = max(visibleLength * 0.5 - halfWidth, 0.0);
	return length(float2(max(along - halfStraight, 0.0), normal)) - halfWidth;
}

float stroke_fitted_gap(float pathLength, float visibleLength, float requestedGap, float gapCount)
{
	float safeGap = max(requestedGap, 0.0);
	if (pathLength <= 0.001 || safeGap <= 0.001)
		return safeGap;

	float safeVisible = max(visibleLength, 0.001);
	float safeGapCount = max(gapCount, 1.0);
	float nominalPeriod = safeVisible + safeGap * safeGapCount;
	float cycles = max(floor(pathLength / nominalPeriod + 0.5), 1.0);
	float maxCycles = max(floor(pathLength / safeVisible), 1.0);
	cycles = min(cycles, maxCycles);
	return max((pathLength / cycles - safeVisible) / safeGapCount, 0.0);
}

float stroke_pattern_mask(float pathCoord, float pathLength, float normalDist, float strokeWidth, float kind, float dashLength, float gap, float offset)
{
	if (kind < 0.5)
		return 1.0;

	float width = max(strokeWidth, 0.001);
	float halfWidth = width * 0.5;
	float safeGap = max(gap, 0.0);
	float visibleLength = max(dashLength, width);

	if (kind < 1.5)
	{
		safeGap = stroke_fitted_gap(pathLength, width, safeGap, 1.0);
		float period = max(width + safeGap, width);
		float phase = fmod(pathCoord + offset, period);
		if (phase < 0.0)
			phase += period;
		float along = min(phase, period - phase);
		return stroke_pattern_coverage_from_dist(length(float2(along, normalDist)) - halfWidth);
	}

	if (kind < 2.5)
	{
		safeGap = stroke_fitted_gap(pathLength, visibleLength, safeGap, 1.0);
		float period = max(visibleLength + safeGap, visibleLength);
		float phase = fmod(pathCoord + offset, period);
		if (phase < 0.0)
			phase += period;
		float along = min(phase, period - phase);
		return stroke_pattern_coverage_from_dist(stroke_capsule_pattern_dist(along, normalDist, visibleLength, halfWidth));
	}

	safeGap = stroke_fitted_gap(pathLength, width + visibleLength, safeGap, 2.0);
	float period = max(width + visibleLength + safeGap * 2.0, width + visibleLength);
	float phase = fmod(pathCoord + offset, period);
	if (phase < 0.0)
		phase += period;

	float dotAlong = min(phase, period - phase);
	float dashCenter = width * 0.5 + safeGap + visibleLength * 0.5;
	float dashAlong = stroke_cycle_distance(phase, dashCenter, period);
	float dotDist = length(float2(dotAlong, normalDist)) - halfWidth;
	float dashDist = stroke_capsule_pattern_dist(dashAlong, normalDist, visibleLength, halfWidth);
	return stroke_pattern_coverage_from_dist(min(dotDist, dashDist));
}

float stroke_path_add_segment(float2 p, float2 a, float2 b, float prefix, inout float bestDist, inout float bestCoord)
{
	float2 ab = b - a;
	float edgeLength = length(ab);
	float t = saturate(dot(p - a, ab) / max(edgeLength * edgeLength, 0.0001));
	float dist = length(p - (a + ab * t));
	if (dist < bestDist)
	{
		bestDist = dist;
		bestCoord = prefix + edgeLength * t;
	}
	return prefix + edgeLength;
}

float stroke_path_add_arc(float2 p, float2 center, float radius, float startAngle, float endAngle, float prefix, inout float bestDist, inout float bestCoord)
{
	if (radius <= 0.0001)
		return prefix;

	float angle = atan2(p.y - center.y, p.x - center.x);
	if (angle < 0.0)
		angle += 6.28318530718;
	if (endAngle > 6.2830 && angle < startAngle)
		angle += 6.28318530718;
	angle = clamp(angle, startAngle, endAngle);

	float2 edge = center + float2(cos(angle), sin(angle)) * radius;
	float dist = length(p - edge);
	if (dist < bestDist)
	{
		bestDist = dist;
		bestCoord = prefix + (angle - startAngle) * radius;
	}
	return prefix + (endAngle - startAngle) * radius;
}

#endif
