#ifndef MGFX_CHAMFER_COMMON_HLSL
#define MGFX_CHAMFER_COMMON_HLSL

float chamfer_segment_dist(float2 p, float2 a, float2 b)
{
	float2 ba = b - a;
	float denom = max(dot(ba, ba), 0.0001);
	float h = saturate(dot(p - a, ba) / denom);
	return length(p - (a + ba * h));
}

float chamfer_edge_side(float2 p, float2 a, float2 b)
{
	float2 e = b - a;
	float2 q = p - a;
	return e.x * q.y - e.y * q.x;
}

float chamfer_edge_depth(float2 p, float2 a, float2 b)
{
	float2 e = b - a;
	float2 q = p - a;
	return chamfer_edge_side(p, a, b) / max(length(e), 0.0001);
}

float chamfer_dist_shape(float2 p, float2 s, float4 cuts)
{
	float limit = min(s.x, s.y) * 0.5;
	float tl = min(cuts.x, limit);
	float tr = min(cuts.y, limit);
	float br = min(cuts.z, limit);
	float bl = min(cuts.w, limit);

	float2 p0 = float2(tl, 0.0);
	float2 p1 = float2(s.x - tr, 0.0);
	float2 p2 = float2(s.x, tr);
	float2 p3 = float2(s.x, s.y - br);
	float2 p4 = float2(s.x - br, s.y);
	float2 p5 = float2(bl, s.y);
	float2 p6 = float2(0.0, s.y - bl);
	float2 p7 = float2(0.0, tl);

	float d = chamfer_segment_dist(p, p0, p1);
	d = min(d, chamfer_segment_dist(p, p1, p2));
	d = min(d, chamfer_segment_dist(p, p2, p3));
	d = min(d, chamfer_segment_dist(p, p3, p4));
	d = min(d, chamfer_segment_dist(p, p4, p5));
	d = min(d, chamfer_segment_dist(p, p5, p6));
	d = min(d, chamfer_segment_dist(p, p6, p7));
	d = min(d, chamfer_segment_dist(p, p7, p0));

	float inside = 1.0;
	inside *= step(0.0, chamfer_edge_side(p, p0, p1));
	inside *= step(0.0, chamfer_edge_side(p, p1, p2));
	inside *= step(0.0, chamfer_edge_side(p, p2, p3));
	inside *= step(0.0, chamfer_edge_side(p, p3, p4));
	inside *= step(0.0, chamfer_edge_side(p, p4, p5));
	inside *= step(0.0, chamfer_edge_side(p, p5, p6));
	inside *= step(0.0, chamfer_edge_side(p, p6, p7));
	inside *= step(0.0, chamfer_edge_side(p, p7, p0));

	return lerp(d, -d, inside);
}

#endif
