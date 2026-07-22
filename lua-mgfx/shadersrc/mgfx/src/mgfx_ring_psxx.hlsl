#include "mgfx_common.hlsl"

#define RING_COLOR_B EXTRA0
#define DRAW_SIZE EXTRA1.xy
#define INNER_RADIUS EXTRA1.z
#define OUTER_RADIUS EXTRA1.w
#define START_RAD EXTRA2.x
#define END_RAD EXTRA2.y
#define ARC_MODE EXTRA2.z
#define RING_FILL_PACKED EXTRA2.w
#define RING_FILL_CURVE floor(RING_FILL_PACKED / 4.0 + 0.001)
#define RING_FILL_KIND (RING_FILL_PACKED - RING_FILL_CURVE * 4.0)
#define RING_FILL_PARAMS EXTRA3

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

float arc_angular_t(float localA, float span)
{
	if (localA <= span)
		return saturate(localA / max(span, 0.0001));

	float toStart = 6.28318530718 - localA;
	float toEnd = localA - span;
	return toStart < toEnd ? 0.0 : 1.0;
}

float4 ring_fill(float2 uv, float r, float innerR, float outerR, float angularT, float4 colorA, float2 pixelPos)
{
	if (RING_FILL_KIND < 0.5)
		return RING_COLOR_B;

	float t = 0.0;
	if (RING_FILL_KIND < 1.5)
	{
		float2 a = RING_FILL_PARAMS.xy;
		float2 b = RING_FILL_PARAMS.zw;
		float2 ab = b - a;
		t = saturate(dot(uv - a, ab) / max(dot(ab, ab), 0.0001));
	}
	else if (RING_FILL_KIND < 2.5)
	{
		if (RING_FILL_PARAMS.w < -0.5)
		{
			t = saturate((r - innerR) / max(outerR - innerR, 0.0001));
		}
		else if (RING_FILL_PARAMS.w > 0.0001)
		{
			float2 radialRadii = max(RING_FILL_PARAMS.zw, float2(0.0001, 0.0001));
			t = saturate(length((uv - RING_FILL_PARAMS.xy) / radialRadii));
		}
		else
		{
			float2 radialScale = DRAW_SIZE / max(min(DRAW_SIZE.x, DRAW_SIZE.y), 0.0001);
			t = saturate(length((uv - RING_FILL_PARAMS.xy) * radialScale) / max(RING_FILL_PARAMS.z, 0.0001));
		}
	}
	else
	{
		if (RING_FILL_PARAMS.w > 0.5)
		{
			float localT = angularT + RING_FILL_PARAMS.z;
			if (ARC_MODE > 0.5)
				t = saturate(localT);
			else
				return mgfx_gradient_lut_conic(localT, RING_FILL_CURVE, pixelPos);
		}
		else
		{
			float angle = atan2(uv.y - RING_FILL_PARAMS.y, uv.x - RING_FILL_PARAMS.x);
			return mgfx_gradient_lut_conic(angle / 6.28318530718 + 0.5 + RING_FILL_PARAMS.z, RING_FILL_CURVE, pixelPos);
		}
	}

	return mgfx_gradient_lut(t, RING_FILL_CURVE, pixelPos);
}

float4 main(PS_INPUT i) : COLOR
{
	float2 p = (i.uv - 0.5) * DRAW_SIZE;
	float r = length(p);
	float innerR = max(INNER_RADIUS, 0.0);
	float outerR = max(OUTER_RADIUS, innerR + 0.001);
	float halfW = (outerR - innerR) * 0.5;
	float midR = (outerR + innerR) * 0.5;
	float ringDist = ring_band_dist(r, innerR, outerR);
	float dist = ringDist;

	float span = END_RAD - START_RAD;
	if (span < 0.0)
		span += 6.28318530718;

	float angle = normalize_angle(atan2(p.y, p.x));
	float startA = normalize_angle(START_RAD);
	float localA = angle - startA;
	if (localA < 0.0)
		localA += 6.28318530718;
	float angularT = arc_angular_t(localA, span);

	if (ARC_MODE > 0.5 && span < 6.282)
	{
		float inArc = step(localA, span);
		float endA = startA + span;

		if (ARC_MODE < 1.5)
		{
			float2 startP = float2(cos(startA), sin(startA)) * midR;
			float2 endP = float2(cos(endA), sin(endA)) * midR;
			float capDist = min(length(p - startP), length(p - endP)) - halfW;
			dist = lerp(capDist, ringDist, inArc);
		}
		else
		{
			float capDist = min(
				radial_segment_dist(p, startA, innerR, outerR),
				radial_segment_dist(p, endA, innerR, outerR)
			);
			dist = max(ringDist, lerp(capDist, -capDist, inArc));
		}
	}

	float4 color = ring_fill(i.uv, r, innerR, outerR, angularT, i.color, i.pos);
	float alpha = color.a * aa_coverage(dist);
	clip(alpha - 0.001);
	return float4(saturate(color.rgb), saturate(alpha));
}
