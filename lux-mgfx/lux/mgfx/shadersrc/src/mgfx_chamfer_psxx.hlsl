#include "mgfx_common.hlsl"
#include "mgfx_chamfer_common.hlsl"

#define CHAMFER_CUTS AUX0
#define INNER_GLOW_COLOR AUX1
#define INNER_GLOW_WIDTH AUX2.x
#define INNER_GLOW_STRENGTH AUX2.y
#define INNER_GLOW_FALLOFF AUX2.z

float inner_glow_profile(float depth, float width, float falloff)
{
	return mgfx_css_inner_effect(depth, width, falloff);
}

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

float4 source_over(float4 top, float4 bottom)
{
	float alpha = top.a + bottom.a * (1.0 - top.a);
	float3 rgb = (top.rgb * top.a + bottom.rgb * bottom.a * (1.0 - top.a)) / max(alpha, 0.0001);
	return float4(saturate(rgb), saturate(alpha));
}

float4 main(PS_INPUT i) : COLOR
{
	float2 size = max(SIZE, float2(0.001, 0.001));
	float dist = chamfer_dist_shape(i.uv * size, size, CHAMFER_CUTS);
	float shape = aa_coverage(dist);
	float4 fillColor = mgfx_fill(i.uv, i.color);
	float fillAlpha = fillColor.a * shape;
	float strokeAlpha = 0.0;

	if (STROKE_WIDTH > 0.0 && STROKE_COLOR.a > 0.0)
	{
		float edgeDist = abs(dist);
		float aa = max(fwidth(edgeDist), 1.0);
		float halfWidth = STROKE_WIDTH * 0.5;
		strokeAlpha = STROKE_COLOR.a * (1.0 - smoothstep(halfWidth - aa, halfWidth + aa, edgeDist));
	}

	float alpha = strokeAlpha + fillAlpha * (1.0 - strokeAlpha);
	float3 rgb = (STROKE_COLOR.rgb * strokeAlpha + fillColor.rgb * fillAlpha * (1.0 - strokeAlpha)) / max(alpha, 0.0001);
	float4 outColor = float4(saturate(rgb), saturate(alpha));

	if (INNER_GLOW_COLOR.a > 0.0 && INNER_GLOW_WIDTH > 0.0 && INNER_GLOW_STRENGTH > 0.0)
	{
		float glow = chamfer_inner_glow(i.uv * size, size, CHAMFER_CUTS, INNER_GLOW_WIDTH, INNER_GLOW_FALLOFF) * shape * max(INNER_GLOW_STRENGTH, 0.0);
		float4 glowColor = float4(saturate(INNER_GLOW_COLOR.rgb), saturate(INNER_GLOW_COLOR.a * glow));
		outColor = source_over(glowColor, outColor);
	}

	clip(outColor.a - 0.001);
	return outColor;
}
