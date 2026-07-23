#ifndef MGFX_MASK_COMMON_HLSL
#define MGFX_MASK_COMMON_HLSL

#define MGFX_MASK_ROUNDED 0.0
#define MGFX_MASK_CHAMFER 1.0
#define MGFX_MASK_CIRCLE 2.0
#define MGFX_MASK_CAPSULE 3.0
#define MGFX_MASK_TEXTURE_A 10.0
#define MGFX_MASK_TEXTURE_R 11.0
#define MGFX_MASK_TEXTURE_G 12.0
#define MGFX_MASK_TEXTURE_B 13.0
#define MGFX_MASK_TEXTURE_LUMA 14.0

float mgfx_mask_sd_roundrect(float2 p, float2 halfSize, float radius)
{
	float2 q = abs(p) - halfSize + radius;
	return min(max(q.x, q.y), 0.0) + length(max(q, 0.0)) - radius;
}

float mgfx_mask_segment_dist(float2 p, float2 a, float2 b)
{
	float2 ba = b - a;
	float denom = max(dot(ba, ba), 0.0001);
	float h = saturate(dot(p - a, ba) / denom);
	return length(p - (a + ba * h));
}

float mgfx_mask_edge_side(float2 p, float2 a, float2 b)
{
	float2 e = b - a;
	float2 q = p - a;
	return e.x * q.y - e.y * q.x;
}

float mgfx_mask_chamfer_dist(float2 p, float2 size, float4 cuts)
{
	float limit = min(size.x, size.y) * 0.5;
	float tl = clamp(cuts.x, 0.0, limit);
	float tr = clamp(cuts.y, 0.0, limit);
	float br = clamp(cuts.z, 0.0, limit);
	float bl = clamp(cuts.w, 0.0, limit);

	float2 p0 = float2(tl, 0.0);
	float2 p1 = float2(size.x - tr, 0.0);
	float2 p2 = float2(size.x, tr);
	float2 p3 = float2(size.x, size.y - br);
	float2 p4 = float2(size.x - br, size.y);
	float2 p5 = float2(bl, size.y);
	float2 p6 = float2(0.0, size.y - bl);
	float2 p7 = float2(0.0, tl);

	float d = mgfx_mask_segment_dist(p, p0, p1);
	d = min(d, mgfx_mask_segment_dist(p, p1, p2));
	d = min(d, mgfx_mask_segment_dist(p, p2, p3));
	d = min(d, mgfx_mask_segment_dist(p, p3, p4));
	d = min(d, mgfx_mask_segment_dist(p, p4, p5));
	d = min(d, mgfx_mask_segment_dist(p, p5, p6));
	d = min(d, mgfx_mask_segment_dist(p, p6, p7));
	d = min(d, mgfx_mask_segment_dist(p, p7, p0));

	float inside = 1.0;
	inside *= step(0.0, mgfx_mask_edge_side(p, p0, p1));
	inside *= step(0.0, mgfx_mask_edge_side(p, p1, p2));
	inside *= step(0.0, mgfx_mask_edge_side(p, p2, p3));
	inside *= step(0.0, mgfx_mask_edge_side(p, p3, p4));
	inside *= step(0.0, mgfx_mask_edge_side(p, p4, p5));
	inside *= step(0.0, mgfx_mask_edge_side(p, p5, p6));
	inside *= step(0.0, mgfx_mask_edge_side(p, p6, p7));
	inside *= step(0.0, mgfx_mask_edge_side(p, p7, p0));

	return lerp(d, -d, inside);
}

float mgfx_mask_procedural_dist(float2 uv, float2 shapeSize, float kind, float radius, float4 params)
{
	float2 p = uv * shapeSize;
	float2 center = shapeSize * 0.5;

	if (kind < 0.5)
	{
		float r = clamp(radius, 0.0, min(center.x, center.y));
		return mgfx_mask_sd_roundrect(p - center, center, r);
	}
	if (kind < 1.5)
		return mgfx_mask_chamfer_dist(p, shapeSize, params);
	if (kind < 2.5)
		return length(p - center) - min(shapeSize.x, shapeSize.y) * 0.5;

	return mgfx_mask_sd_roundrect(p - center, center, min(shapeSize.x, shapeSize.y) * 0.5);
}

float mgfx_mask_texture_value(float2 uv, float4 maskUV, float kind)
{
	float2 sampleUV = lerp(maskUV.xy, maskUV.zw, saturate(uv));
	float4 value = tex2D(Tex2, sampleUV);

	if (kind < 10.5) return value.a;
	if (kind < 11.5) return value.r;
	if (kind < 12.5) return value.g;
	if (kind < 13.5) return value.b;
	return dot(value.rgb, float3(0.2126, 0.7152, 0.0722));
}

float mgfx_mask_texture_sample(float2 uv, float4 maskUV, float kind, float invert)
{
	float value = mgfx_mask_texture_value(uv, maskUV, kind);
	return lerp(value, 1.0 - value, invert);
}

#endif
