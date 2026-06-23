#include "mgfx_common.hlsl"

#define GLOW_COLOR EXTRA0
#define CHAMFER_CUTS EXTRA2
#define GLOW_WIDTH EXTRA3.x
#define GLOW_STRENGTH EXTRA3.y
#define GLOW_FALLOFF EXTRA3.z

float inner_glow_profile(float depth, float width, float falloff)
{
	return mgfx_css_inner_effect(depth, width, falloff);
}

#include "mgfx_chamfer_common.hlsl"

float chamfer_inner_glow(float2 p, float2 s, float4 cuts, float width, float falloff)
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

	float effect = 0.0;
	effect = mgfx_css_combine_effect(effect, inner_glow_profile(chamfer_edge_depth(p, p0, p1), width, falloff));
	effect = mgfx_css_combine_effect(effect, inner_glow_profile(chamfer_edge_depth(p, p1, p2), width, falloff));
	effect = mgfx_css_combine_effect(effect, inner_glow_profile(chamfer_edge_depth(p, p2, p3), width, falloff));
	effect = mgfx_css_combine_effect(effect, inner_glow_profile(chamfer_edge_depth(p, p3, p4), width, falloff));
	effect = mgfx_css_combine_effect(effect, inner_glow_profile(chamfer_edge_depth(p, p4, p5), width, falloff));
	effect = mgfx_css_combine_effect(effect, inner_glow_profile(chamfer_edge_depth(p, p5, p6), width, falloff));
	effect = mgfx_css_combine_effect(effect, inner_glow_profile(chamfer_edge_depth(p, p6, p7), width, falloff));
	effect = mgfx_css_combine_effect(effect, inner_glow_profile(chamfer_edge_depth(p, p7, p0), width, falloff));
	return effect;
}

float4 main(PS_INPUT i) : COLOR
{
	float2 p = i.uv * SIZE;
	float width = max(GLOW_WIDTH, 0.001);
	float falloff = max(GLOW_FALLOFF, 0.001);

	float outerDist = chamfer_dist_shape(p, SIZE, CHAMFER_CUTS);
	float shape = aa_coverage(outerDist);
	float glow = chamfer_inner_glow(p, SIZE, CHAMFER_CUTS, width, falloff) * shape * max(GLOW_STRENGTH, 0.0);
	float alpha = saturate(GLOW_COLOR.a * glow);

	clip(alpha - 0.001);
	return float4(saturate(GLOW_COLOR.rgb), alpha);
}
