#include "mgfx_common.hlsl"

#define DRAW_SIZE EXTRA0.xy
#define SHADOW_COLOR EXTRA1
#define SHADOW_SHAPE EXTRA2
#define SHADOW_PARAMS EXTRA3

#define OUTER_COLOR AUX0
#define OUTER_SHAPE AUX1
#define OUTER_PARAMS AUX2

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

float ring_dist(float2 p, float4 shape, float4 params)
{
	float innerR = max(shape.z, 0.0);
	float outerR = max(shape.w, innerR + 0.001);
	float r = length(p);
	float halfW = (outerR - innerR) * 0.5;
	float midR = (outerR + innerR) * 0.5;
	float bandDist = ring_band_dist(r, innerR, outerR);
	float dist = bandDist;
	float startRad = params.x;
	float endRad = params.y;
	float mode = params.z;
	float span = endRad - startRad;

	if (span < 0.0)
		span += 6.28318530718;

	if (mode > 0.5 && span < 6.282)
	{
		float angle = normalize_angle(atan2(p.y, p.x));
		float startA = normalize_angle(startRad);
		float localA = angle - startA;
		if (localA < 0.0)
			localA += 6.28318530718;

		float inArc = step(localA, span);
		float endA = startA + span;

		if (mode < 1.5)
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

float4 source_over(float4 top, float4 bottom)
{
	float alpha = top.a + bottom.a * (1.0 - top.a);
	float3 rgb = (top.rgb * top.a + bottom.rgb * bottom.a * (1.0 - top.a)) / max(alpha, 0.0001);
	return float4(saturate(rgb), saturate(alpha));
}

float4 main(PS_INPUT i) : COLOR
{
	float2 pos = i.uv * DRAW_SIZE;

	float shadowDist = ring_dist(pos - SHADOW_SHAPE.xy, SHADOW_SHAPE, SHADOW_PARAMS);
	float shadowEffect =
		mgfx_css_shadow_effect(shadowDist, max(SHADOW_PARAMS.w, 0.001), max(AUX3.x, 0.001))
		* max(AUX3.y, 0.0);
	float4 shadowColor = float4(saturate(SHADOW_COLOR.rgb), saturate(SHADOW_COLOR.a * shadowEffect));

	float outerDist = ring_dist(pos - OUTER_SHAPE.xy, OUTER_SHAPE, OUTER_PARAMS);
	float outerEffect =
		mgfx_css_outer_effect(outerDist, max(OUTER_PARAMS.w, 0.001), max(AUX3.z, 0.001))
		* max(AUX3.w, 0.0);
	float4 outerColor = float4(saturate(OUTER_COLOR.rgb), saturate(OUTER_COLOR.a * outerEffect));

	float4 color = source_over(outerColor, shadowColor);
	clip(color.a - 0.001);
	return color;
}
