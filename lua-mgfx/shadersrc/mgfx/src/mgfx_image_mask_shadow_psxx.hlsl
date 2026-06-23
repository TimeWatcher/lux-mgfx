#include "mgfx_common.hlsl"

#define SHADOW_COLOR EXTRA0
#define SHAPE_SIZE EXTRA1.xy
#define MASK_KIND_PACKED EXTRA1.z
#define MASK_RADIUS EXTRA1.w
#define SHADOW_SPREAD EXTRA2.x
#define SHADOW_OPACITY EXTRA2.y
#define SHADOW_SOFTNESS EXTRA2.z
#define SHADOW_EXTENT EXTRA2.w
#define MASK_PARAMS EXTRA3

#define MASK_ROUNDED 0.0
#define MASK_CHAMFER 1.0
#define MASK_CIRCLE 2.0
#define MASK_CAPSULE 3.0
#define MASK_TEXTURE_A 10.0
#define MASK_TEXTURE_R 11.0
#define MASK_TEXTURE_G 12.0
#define MASK_TEXTURE_B 13.0
#define MASK_TEXTURE_LUMA 14.0

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

float texture_shadow(float2 localUV, float kind, float invert)
{
	float blur = max(SHADOW_SPREAD, 0.001);
	float falloff = max(1.0 / max(SHADOW_SOFTNESS, 0.1), 0.35);
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

	return saturate(accum / max(total, 0.0001));
}

float4 main(PS_INPUT i) : COLOR
{
	float invert = step(128.0, MASK_KIND_PACKED);
	float kind = MASK_KIND_PACKED - invert * 128.0;
	float blur = max(SHADOW_SPREAD, 0.001);
	float extent = max(max(SHADOW_EXTENT, blur), 1.0);
	float opacity = max(SHADOW_OPACITY, 0.0);
	float2 expandedSize = SHAPE_SIZE + extent * 2.0;
	float2 localPos = i.uv * expandedSize - extent;
	float2 localUV = localPos / max(SHAPE_SIZE, float2(1.0, 1.0));
	float shadow = 0.0;

	if (kind < 9.5)
	{
		float dist = procedural_dist(localPos, kind);
		dist = lerp(dist, -dist, invert);
		shadow = mgfx_css_shadow_effect(dist, blur, max(1.0 / max(SHADOW_SOFTNESS, 0.1), 0.35));
	}
	else
	{
		shadow = texture_shadow(localUV, kind, invert);
	}

	float alpha = SHADOW_COLOR.a * opacity * shadow;
	clip(alpha - 0.001);
	return float4(saturate(SHADOW_COLOR.rgb), saturate(alpha));
}
