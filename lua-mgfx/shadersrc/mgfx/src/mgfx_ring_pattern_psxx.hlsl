#include "mgfx_common.hlsl"

#define PATTERN_EXTRA EXTRA0
#define DRAW_SIZE EXTRA1.xy
#define INNER_RADIUS EXTRA1.z
#define OUTER_RADIUS EXTRA1.w
#define START_RAD EXTRA2.x
#define END_RAD EXTRA2.y
#define ARC_MODE EXTRA2.z
#define PATTERN_KIND EXTRA2.w
#define PATTERN_DIR EXTRA3.xy
#define PATTERN_SPACING EXTRA3.z
#define PATTERN_WIDTH EXTRA3.w

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

#include "mgfx_pattern_common.hlsl"

float4 main(PS_INPUT i) : COLOR
{
	float2 p = (i.uv - 0.5) * DRAW_SIZE;
	float dist = ring_dist(p);
	float shape = aa_coverage(dist);
	float2 pos = i.uv * DRAW_SIZE;
	float stripe = pattern_stripe_coverage(pos, PATTERN_DIR, PATTERN_SPACING, PATTERN_WIDTH, PATTERN_EXTRA.y);
	float smoke = pattern_smoke_coverage(pos, PATTERN_DIR, PATTERN_SPACING, PATTERN_WIDTH, PATTERN_EXTRA.y, PATTERN_EXTRA.z, PATTERN_EXTRA.w, PATTERN_EXTRA.x);
	float4 wornTerms = pattern_worn_terms(pos, dist, PATTERN_DIR, PATTERN_SPACING, PATTERN_EXTRA.y, PATTERN_WIDTH, PATTERN_EXTRA.x);
	float worn = max(max(wornTerms.x, wornTerms.y), max(wornTerms.z, wornTerms.w));
	float pattern = PATTERN_KIND < 0.5 ? stripe : (PATTERN_KIND < 1.5 ? smoke : worn);
	float alpha = i.color.a * shape * pattern;
	clip(alpha - 0.001);
	float4 color = PATTERN_KIND < 1.5 ? i.color * (shape * pattern) : pattern_worn_color(i.color, wornTerms, shape);
	return float4(saturate(color.rgb), saturate(color.a));
}
