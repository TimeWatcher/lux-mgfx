#include "mgfx_common.hlsl"

#define MASK_STROKE_COLOR EXTRA0
#define SHAPE_SIZE EXTRA1.xy
#define MASK_KIND_PACKED EXTRA1.z
#define MASK_PARAM EXTRA1.w
#define SOURCE_UV EXTRA2
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

float procedural_dist(float2 uv, float kind)
{
	float2 p = uv * SHAPE_SIZE;
	float2 center = SHAPE_SIZE * 0.5;
	float dist = 1.0;

	if (kind < 0.5)
	{
		float r = clamp(MASK_PARAM, 0.0, min(center.x, center.y));
		dist = sd_roundrect_mask(p - center, center, r);
	}
	else if (kind < 1.5)
	{
		dist = chamfer_dist_mask(p, SHAPE_SIZE, MASK_PARAMS);
	}
	else if (kind < 2.5)
	{
		dist = length(p - center) - min(SHAPE_SIZE.x, SHAPE_SIZE.y) * 0.5;
	}
	else
	{
		dist = sd_roundrect_mask(p - center, center, min(SHAPE_SIZE.x, SHAPE_SIZE.y) * 0.5);
	}

	return dist;
}

float texture_mask_value(float2 uv, float kind)
{
	float2 maskUV = lerp(MASK_PARAMS.xy, MASK_PARAMS.zw, saturate(uv));
	float4 m = tex2D(Tex1, maskUV);

	if (kind < 10.5) return m.a;
	if (kind < 11.5) return m.r;
	if (kind < 12.5) return m.g;
	if (kind < 13.5) return m.b;
	return dot(m.rgb, float3(0.2126, 0.7152, 0.0722));
}

float texture_mask_sample(float2 uv, float kind, float invert)
{
	float v = texture_mask_value(uv, kind);
	return lerp(v, 1.0 - v, invert);
}

float texture_mask_inner(float2 uv, float kind, float invert, float strokeWidth)
{
	float2 stepUV = strokeWidth / max(SHAPE_SIZE, float2(1.0, 1.0));
	float2 diagUV = stepUV * 0.70710678;
	float v = texture_mask_sample(uv, kind, invert);

	v = min(v, texture_mask_sample(uv + float2(stepUV.x, 0.0), kind, invert));
	v = min(v, texture_mask_sample(uv - float2(stepUV.x, 0.0), kind, invert));
	v = min(v, texture_mask_sample(uv + float2(0.0, stepUV.y), kind, invert));
	v = min(v, texture_mask_sample(uv - float2(0.0, stepUV.y), kind, invert));
	v = min(v, texture_mask_sample(uv + float2(diagUV.x, diagUV.y), kind, invert));
	v = min(v, texture_mask_sample(uv + float2(-diagUV.x, diagUV.y), kind, invert));
	v = min(v, texture_mask_sample(uv + float2(diagUV.x, -diagUV.y), kind, invert));
	v = min(v, texture_mask_sample(uv - float2(diagUV.x, diagUV.y), kind, invert));

	return saturate(v);
}

float4 main(PS_INPUT i) : COLOR
{
	float sourceAlphaMask = step(65536.0, MASK_KIND_PACKED);
	float packedKindBase = MASK_KIND_PACKED - sourceAlphaMask * 65536.0;
	float strokeWidth = floor(packedKindBase / 256.0 + 0.001);
	float packedKind = packedKindBase - strokeWidth * 256.0;
	float invert = step(128.0, packedKind);
	float kind = packedKind - invert * 128.0;
	float2 sourceUV = lerp(SOURCE_UV.xy, SOURCE_UV.zw, saturate(i.uv));
	float4 texColor = tex2D(TexBase, sourceUV) * i.color;

	float outer = 0.0;
	float inner = 0.0;

	if (kind < 9.5)
	{
		float dist = procedural_dist(i.uv, kind);
		dist = lerp(dist, -dist, invert);
		outer = aa_coverage(dist);
		inner = strokeWidth > 0.0 && MASK_STROKE_COLOR.a > 0.0 ? aa_coverage(dist + strokeWidth) : outer;
	}
	else
	{
		outer = texture_mask_sample(i.uv, kind, invert);
		inner = strokeWidth > 0.0 && MASK_STROKE_COLOR.a > 0.0 ? texture_mask_inner(i.uv, kind, invert, strokeWidth) : outer;
	}

	float borderMask = saturate(outer - inner);
	float fillMask = sourceAlphaMask > 0.5 ? 1.0 : (strokeWidth > 0.0 && MASK_STROKE_COLOR.a > 0.0 ? inner : outer);
	float texAlpha = texColor.a * fillMask;
	float strokeAlpha = MASK_STROKE_COLOR.a * borderMask;
	float alpha = texAlpha + strokeAlpha;
	clip(alpha - 0.001);

	float3 rgb = (texColor.rgb * texAlpha + MASK_STROKE_COLOR.rgb * strokeAlpha) / alpha;
	return float4(saturate(rgb), saturate(alpha));
}
