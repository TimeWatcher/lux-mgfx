#include "mgfx_common.hlsl"

#define GLOW_COLOR EXTRA0
#define SHAPE_SIZE EXTRA1.xy
#define INNER_RADIUS EXTRA1.z
#define OUTER_RADIUS EXTRA1.w
#define START_RAD EXTRA2.x
#define END_RAD EXTRA2.y
#define ARC_MODE EXTRA2.z
#define GLOW_SPREAD EXTRA2.w
#define GLOW_WIDTH EXTRA3.x
#define GLOW_STRENGTH EXTRA3.y
#define GLOW_FALLOFF EXTRA3.z

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

float4 main(PS_INPUT i) : COLOR
{
	float spread = max(GLOW_SPREAD, 1.0);
	float2 drawSize = SHAPE_SIZE + spread * 2.0;
	float2 p = (i.uv - 0.5) * drawSize;
	float dist = ring_dist(p);
	float outside = max(dist, 0.0);
	float width = max(GLOW_WIDTH, 0.001);
	float falloff = max(GLOW_FALLOFF, 0.001);
	float outsideMask = 1.0 - aa_coverage(dist);
	float edge = 1.0 - smoothstep(0.0, width, outside);
	float glow = pow(saturate(edge), falloff) * outsideMask * max(GLOW_STRENGTH, 0.0);
	float alpha = saturate(GLOW_COLOR.a * glow);

	clip(alpha - 0.001);
	return float4(saturate(GLOW_COLOR.rgb), alpha);
}
