#include "mgfx_common.hlsl"

#define DRAW_SIZE EXTRA0.xy
#define SHAPE_SIZE EXTRA0.zw
#define MASK_KIND_PACKED EXTRA1.x
#define MASK_RADIUS EXTRA1.y
#define SHADOW_COLOR EXTRA2
#define SHADOW_OFFSET EXTRA3.xy
#define SHADOW_WIDTH EXTRA3.z
#define SHADOW_OPACITY EXTRA3.w

#define OUTER_COLOR AUX0
#define OUTER_OFFSET AUX1.xy
#define OUTER_WIDTH AUX1.z
#define OUTER_OPACITY AUX1.w
#define SHADOW_SOFTNESS AUX2.x
#define OUTER_SOFTNESS AUX2.y
#define MASK_PARAMS AUX3

#define MASK_TEXTURE_A 10.0

float sd_roundrect_mask(float2 p, float2 halfSize, float radius)
{
	float2 q = abs(p) - halfSize + radius;
	return min(max(q.x, q.y), 0.0) + length(max(q, 0.0)) - radius;
}

float segment_dist_mask(float2 p, float2 a, float2 b)
{
	float2 ba = b - a;
	float denom = max(dot(ba, ba), 0.0001);
	float h = saturate(dot(p - a, ba) / denom);
	return length(p - (a + ba * h));
}

float edge_side_mask(float2 p, float2 a, float2 b)
{
	float2 e = b - a;
	float2 q = p - a;
	return e.x * q.y - e.y * q.x;
}

float chamfer_dist_mask(float2 p, float2 s, float4 cuts)
{
	float limit = min(s.x, s.y) * 0.5;
	float tl = clamp(cuts.x, 0.0, limit);
	float tr = clamp(cuts.y, 0.0, limit);
	float br = clamp(cuts.z, 0.0, limit);
	float bl = clamp(cuts.w, 0.0, limit);

	float2 p0 = float2(tl, 0.0);
	float2 p1 = float2(s.x - tr, 0.0);
	float2 p2 = float2(s.x, tr);
	float2 p3 = float2(s.x, s.y - br);
	float2 p4 = float2(s.x - br, s.y);
	float2 p5 = float2(bl, s.y);
	float2 p6 = float2(0.0, s.y - bl);
	float2 p7 = float2(0.0, tl);

	float d = segment_dist_mask(p, p0, p1);
	d = min(d, segment_dist_mask(p, p1, p2));
	d = min(d, segment_dist_mask(p, p2, p3));
	d = min(d, segment_dist_mask(p, p3, p4));
	d = min(d, segment_dist_mask(p, p4, p5));
	d = min(d, segment_dist_mask(p, p5, p6));
	d = min(d, segment_dist_mask(p, p6, p7));
	d = min(d, segment_dist_mask(p, p7, p0));

	float inside = 1.0;
	inside *= step(0.0, edge_side_mask(p, p0, p1));
	inside *= step(0.0, edge_side_mask(p, p1, p2));
	inside *= step(0.0, edge_side_mask(p, p2, p3));
	inside *= step(0.0, edge_side_mask(p, p3, p4));
	inside *= step(0.0, edge_side_mask(p, p4, p5));
	inside *= step(0.0, edge_side_mask(p, p5, p6));
	inside *= step(0.0, edge_side_mask(p, p6, p7));
	inside *= step(0.0, edge_side_mask(p, p7, p0));

	return lerp(d, -d, inside);
}

float procedural_dist(float2 p, float kind)
{
	float2 center = SHAPE_SIZE * 0.5;

	if (kind < 0.5)
	{
		float r = clamp(MASK_RADIUS, 0.0, min(center.x, center.y));
		return sd_roundrect_mask(p - center, center, r);
	}

	if (kind < 1.5)
		return chamfer_dist_mask(p, SHAPE_SIZE, MASK_PARAMS);

	if (kind < 2.5)
		return length(p - center) - min(SHAPE_SIZE.x, SHAPE_SIZE.y) * 0.5;

	return sd_roundrect_mask(p - center, center, min(SHAPE_SIZE.x, SHAPE_SIZE.y) * 0.5);
}

float texture_mask_value(float2 localUV, float kind)
{
	float2 maskUV = lerp(MASK_PARAMS.xy, MASK_PARAMS.zw, saturate(localUV));
	float4 m = tex2D(Tex1, maskUV);

	if (kind < 10.5) return m.a;
	if (kind < 11.5) return m.r;
	if (kind < 12.5) return m.g;
	if (kind < 13.5) return m.b;
	return dot(m.rgb, float3(0.2126, 0.7152, 0.0722));
}

float texture_mask_sample(float2 localUV, float kind, float invert)
{
	float inBounds = step(0.0, localUV.x) * step(localUV.x, 1.0) * step(0.0, localUV.y) * step(localUV.y, 1.0);
	float v = texture_mask_value(localUV, kind);
	return inBounds * lerp(v, 1.0 - v, invert);
}

float texture_effect(float2 localUV, float kind, float invert, float width, float softness, bool outsideOnly)
{
	float blur = max(width, 0.001);
	float falloff = max(1.0 / max(softness, 0.1), 0.35);
	float2 stepUV = blur / max(SHAPE_SIZE, float2(1.0, 1.0));
	float center = texture_mask_sample(localUV, kind, invert);
	float accum = center;
	float total = 1.0;

	[unroll]
	for (int ring = 1; ring <= 4; ring++)
	{
		float t = ring / 4.0;
		float2 d = stepUV * t;
		float weight = exp2(-2.88539008 * t * t * falloff);

		accum += texture_mask_sample(localUV + float2(d.x, 0.0), kind, invert) * weight;
		accum += texture_mask_sample(localUV - float2(d.x, 0.0), kind, invert) * weight;
		accum += texture_mask_sample(localUV + float2(0.0, d.y), kind, invert) * weight;
		accum += texture_mask_sample(localUV - float2(0.0, d.y), kind, invert) * weight;
		accum += texture_mask_sample(localUV + d * 0.70710678, kind, invert) * weight;
		accum += texture_mask_sample(localUV + float2(-d.x, d.y) * 0.70710678, kind, invert) * weight;
		accum += texture_mask_sample(localUV + float2(d.x, -d.y) * 0.70710678, kind, invert) * weight;
		accum += texture_mask_sample(localUV - d * 0.70710678, kind, invert) * weight;
		total += weight * 8.0;
	}

	float effect = saturate(accum / max(total, 0.0001));
	return outsideOnly ? saturate(effect * (1.0 - center)) : effect;
}

float4 source_over(float4 top, float4 bottom)
{
	float alpha = top.a + bottom.a * (1.0 - top.a);
	float3 rgb = (top.rgb * top.a + bottom.rgb * bottom.a * (1.0 - top.a)) / max(alpha, 0.0001);
	return float4(saturate(rgb), saturate(alpha));
}

float4 main(PS_INPUT i) : COLOR
{
	float invert = step(128.0, MASK_KIND_PACKED);
	float kind = MASK_KIND_PACKED - invert * 128.0;
	float2 pos = i.uv * DRAW_SIZE;

	float2 shadowLocalPos = pos - SHADOW_OFFSET;
	float2 shadowLocalUV = shadowLocalPos / max(SHAPE_SIZE, float2(1.0, 1.0));
	float2 outerLocalPos = pos - OUTER_OFFSET;
	float2 outerLocalUV = outerLocalPos / max(SHAPE_SIZE, float2(1.0, 1.0));

	float shadowEffect = 0.0;
	float outerEffect = 0.0;
	if (kind < MASK_TEXTURE_A - 0.5)
	{
		float shadowDist = procedural_dist(shadowLocalPos, kind);
		float outerDist = procedural_dist(outerLocalPos, kind);
		shadowDist = lerp(shadowDist, -shadowDist, invert);
		outerDist = lerp(outerDist, -outerDist, invert);
		shadowEffect = mgfx_css_shadow_effect(shadowDist, max(SHADOW_WIDTH, 0.001), max(1.0 / max(SHADOW_SOFTNESS, 0.1), 0.35));
		outerEffect = mgfx_css_outer_effect(outerDist, max(OUTER_WIDTH, 0.001), max(1.0 / max(OUTER_SOFTNESS, 0.1), 0.35));
	}
	else
	{
		shadowEffect = texture_effect(shadowLocalUV, kind, invert, SHADOW_WIDTH, SHADOW_SOFTNESS, false);
		outerEffect = texture_effect(outerLocalUV, kind, invert, OUTER_WIDTH, OUTER_SOFTNESS, true);
	}

	float4 shadowColor = float4(saturate(SHADOW_COLOR.rgb), saturate(SHADOW_COLOR.a * max(SHADOW_OPACITY, 0.0) * shadowEffect));
	float4 outerColor = float4(saturate(OUTER_COLOR.rgb), saturate(OUTER_COLOR.a * max(OUTER_OPACITY, 0.0) * outerEffect));
	float4 color = source_over(outerColor, shadowColor);
	clip(color.a - 0.001);
	return color;
}
