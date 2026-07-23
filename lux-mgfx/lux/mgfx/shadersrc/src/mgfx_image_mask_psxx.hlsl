#include "mgfx_common.hlsl"
#include "mgfx_mask_common.hlsl"

#define MASK_STROKE_COLOR EXTRA0
#define SHAPE_SIZE EXTRA1.xy
#define MASK_KIND_PACKED EXTRA1.z
#define MASK_PARAM EXTRA1.w
#define SOURCE_UV EXTRA2
#define MASK_PARAMS EXTRA3

float procedural_dist(float2 uv, float kind)
{
	return mgfx_mask_procedural_dist(uv, SHAPE_SIZE, kind, MASK_PARAM, MASK_PARAMS);
}

float texture_mask_sample(float2 uv, float kind, float invert)
{
	return mgfx_mask_texture_sample(uv, MASK_PARAMS, kind, invert);
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
	float4 texColor = tex2D(Tex1, sourceUV) * i.color;

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
