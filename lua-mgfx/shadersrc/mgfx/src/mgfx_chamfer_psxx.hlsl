#include "mgfx_common.hlsl"
#include "mgfx_chamfer_common.hlsl"

#define CHAMFER_CUTS Constants0
#define INNER_GLOW_COLOR Constants1
#define INNER_GLOW_WIDTH Constants2.x
#define INNER_GLOW_STRENGTH Constants2.y
#define INNER_GLOW_FALLOFF Constants2.z

float inner_glow_profile(float depth, float width, float falloff)
{
	float t = max(depth, 0.0) / max(width, 0.001);
	float decay = max(falloff, 0.001) * 1.55;
	return exp2(-pow(t, 1.35) * decay);
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
		strokeAlpha = STROKE_COLOR.a * (1.0 - smoothstep(STROKE_WIDTH - aa, STROKE_WIDTH + aa, edgeDist));
	}

	float alpha = strokeAlpha + fillAlpha * (1.0 - strokeAlpha);
	float3 rgb = (STROKE_COLOR.rgb * strokeAlpha + fillColor.rgb * fillAlpha * (1.0 - strokeAlpha)) / max(alpha, 0.0001);
	float4 outColor = float4(saturate(rgb), saturate(alpha));

	if (INNER_GLOW_COLOR.a > 0.0 && INNER_GLOW_WIDTH > 0.0 && INNER_GLOW_STRENGTH > 0.0)
	{
		float depth = max(-dist, 0.0);
		float glow = inner_glow_profile(depth, INNER_GLOW_WIDTH, INNER_GLOW_FALLOFF) * shape * max(INNER_GLOW_STRENGTH, 0.0);
		float4 glowColor = float4(saturate(INNER_GLOW_COLOR.rgb), saturate(INNER_GLOW_COLOR.a * glow));
		outColor = source_over(glowColor, outColor);
	}

	clip(outColor.a - 0.001);
	return outColor;
}
