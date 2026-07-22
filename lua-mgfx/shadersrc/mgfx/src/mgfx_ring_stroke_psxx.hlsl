#include "mgfx_common.hlsl"

#define RING_STROKE_COLOR EXTRA0
#define DRAW_SIZE EXTRA1.xy
#define INNER_RADIUS EXTRA1.z
#define OUTER_RADIUS EXTRA1.w
#define START_RAD EXTRA2.x
#define END_RAD EXTRA2.y
#define ARC_MODE EXTRA2.z
#define RING_STROKE_WIDTH EXTRA2.w
#define RING_STROKE_KIND EXTRA3.x
#define RING_STROKE_DASH_LENGTH EXTRA3.y
#define RING_STROKE_GAP EXTRA3.z
#define RING_STROKE_OFFSET EXTRA3.w

#include "mgfx_stroke_pattern_common.hlsl"

float normalize_angle(float a)
{
	return a < 0.0 ? a + 6.28318530718 : a;
}

float ring_band_dist(float r, float innerR, float outerR)
{
	if (innerR <= 0.001)
		return r - outerR;

	float halfW = (outerR - innerR) * 0.5;
	float midR = (outerR + innerR) * 0.5;
	return abs(r - midR) - halfW;
}

float radial_segment_dist(float2 p, float angle, float innerR, float outerR)
{
	float2 dir = float2(cos(angle), sin(angle));
	float along = clamp(dot(p, dir), innerR, outerR);
	return length(p - dir * along);
}

float ring_dist(float2 p)
{
	float r = length(p);
	float innerR = max(INNER_RADIUS, 0.0);
	float outerR = max(OUTER_RADIUS, innerR + 0.001);
	float halfW = (outerR - innerR) * 0.5;
	float midR = (outerR + innerR) * 0.5;
	float bandDist = ring_band_dist(r, innerR, outerR);
	float dist = bandDist;
	float span = END_RAD - START_RAD;

	if (span < 0.0)
		span += 6.28318530718;

	if (ARC_MODE > 0.5 && span < 6.282)
	{
		float angle = normalize_angle(atan2(p.y, p.x));
		float startA = normalize_angle(START_RAD);
		float localA = angle - startA;
		if (localA < 0.0)
			localA += 6.28318530718;

		float inArc = step(localA, span);
		float endA = startA + span;

		if (ARC_MODE < 1.5)
		{
			float2 startP = float2(cos(startA), sin(startA)) * midR;
			float2 endP = float2(cos(endA), sin(endA)) * midR;
			float capDist = min(length(p - startP), length(p - endP)) - halfW;
			dist = lerp(capDist, bandDist, inArc);
		}
		else
		{
			float capDist = min(
				radial_segment_dist(p, startA, innerR, outerR),
				radial_segment_dist(p, endA, innerR, outerR)
			);
			dist = max(bandDist, lerp(capDist, -capDist, inArc));
		}
	}

	return dist;
}

float2 ring_rotate(float2 p, float angle)
{
	float s = sin(angle);
	float c = cos(angle);
	return float2(p.x * c - p.y * s, p.x * s + p.y * c);
}

float ring_add_arc(float2 p, float radius, float startAngle, float endAngle, float prefix, float reverse, inout float bestDist, inout float bestCoord)
{
	if (radius <= 0.0001)
		return prefix;
	float angle = atan2(p.y, p.x);
	if (angle < 0.0)
		angle += 6.28318530718;
	angle = clamp(angle, startAngle, endAngle);
	float2 edge = float2(cos(angle), sin(angle)) * radius;
	float dist = length(p - edge);
	if (dist < bestDist)
	{
		bestDist = dist;
		float along = reverse > 0.5 ? endAngle - angle : angle - startAngle;
		bestCoord = prefix + along * radius;
	}
	return prefix + (endAngle - startAngle) * radius;
}

float ring_path_coord(float2 p)
{
	float innerR = max(INNER_RADIUS, 0.0);
	float outerR = max(OUTER_RADIUS, innerR + 0.001);
	float halfW = (outerR - innerR) * 0.5;
	float midR = (outerR + innerR) * 0.5;
	float span = END_RAD - START_RAD;
	if (span < 0.0)
		span += 6.28318530718;
	if (ARC_MODE < 0.5 || span >= 6.282)
	{
		float angle = normalize_angle(atan2(p.y, p.x)) - normalize_angle(START_RAD);
		if (angle < 0.0)
			angle += 6.28318530718;
		float r = length(p);
		return abs(r - outerR) <= abs(r - innerR) ? angle * outerR : angle * innerR;
	}

	float2 localP = ring_rotate(p, -START_RAD);
	float bestDist = 100000.0;
	float bestCoord = 0.0;
	float prefix = ring_add_arc(localP, outerR, 0.0, span, 0.0, 0.0, bestDist, bestCoord);
	float2 endDir = float2(cos(span), sin(span));
	if (ARC_MODE < 1.5)
	{
		float2 endLocal = ring_rotate(localP, -span);
		prefix = stroke_path_add_arc(endLocal, float2(midR, 0.0), halfW, 0.0, 3.14159265359, prefix, bestDist, bestCoord);
	}
	else
	{
		prefix = stroke_path_add_segment(localP, endDir * outerR, endDir * innerR, prefix, bestDist, bestCoord);
	}
	prefix = ring_add_arc(localP, innerR, 0.0, span, prefix, 1.0, bestDist, bestCoord);
	if (ARC_MODE < 1.5)
	{
		stroke_path_add_arc(localP, float2(midR, 0.0), halfW, 3.14159265359, 6.28318530718, prefix, bestDist, bestCoord);
	}
	else
	{
		stroke_path_add_segment(localP, float2(innerR, 0.0), float2(outerR, 0.0), prefix, bestDist, bestCoord);
	}
	return bestCoord;
}

float4 main(PS_INPUT i) : COLOR
{
	float2 p = (i.uv - 0.5) * DRAW_SIZE;
	float dist = ring_dist(p);
	float width = max(RING_STROKE_WIDTH, 0.0);
	float stroke = aa_coverage(abs(dist) - width * 0.5);
	float pattern = stroke_pattern_mask(ring_path_coord(p), dist, width, RING_STROKE_KIND, RING_STROKE_DASH_LENGTH, RING_STROKE_GAP, RING_STROKE_OFFSET);
	float alpha = RING_STROKE_COLOR.a * stroke * pattern;

	clip(alpha - 0.001);
	return float4(saturate(RING_STROKE_COLOR.rgb), saturate(alpha));
}
