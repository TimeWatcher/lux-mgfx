#ifndef MGFX_COMMON_HLSL
#define MGFX_COMMON_HLSL

sampler TexBase : register(s0);
sampler Tex1    : register(s1);
sampler Tex2    : register(s2);
sampler Tex3    : register(s3);

float2 TexBaseSize : register(c4);
float2 Tex1Size    : register(c5);
float2 Tex2Size    : register(c6);
float2 Tex3Size    : register(c7);

const float4 Constants0 : register(c0);
const float4 Constants1 : register(c1);
const float4 Constants2 : register(c2);
const float4 Constants3 : register(c3);
const float4x4 MGFXExtraParams : register(c11);
const float4x4 MGFXAuxParams : register(c15);

#define EXTRA0 MGFXExtraParams[0]
#define EXTRA1 MGFXExtraParams[1]
#define EXTRA2 MGFXExtraParams[2]
#define EXTRA3 MGFXExtraParams[3]

#define AUX0 MGFXAuxParams[0]
#define AUX1 MGFXAuxParams[1]
#define AUX2 MGFXAuxParams[2]
#define AUX3 MGFXAuxParams[3]

#define FILL_COLOR_B EXTRA0
#define SIZE EXTRA1.xy
#define STYLE_PACKED EXTRA1.z
#define FILL_KIND floor(STYLE_PACKED / 256.0 + 0.001)
#define STROKE_WIDTH (STYLE_PACKED - FILL_KIND * 256.0)
#define SHAPE_RADIUS EXTRA1.w
#define FILL_PARAMS EXTRA2
#define STROKE_COLOR EXTRA3

#define FILL_SOLID 0.0
#define FILL_LINEAR 1.0
#define FILL_RADIAL 2.0
#define FILL_CONIC 3.0

struct PS_INPUT
{
	float2 uv    : TEXCOORD0;
	float4 color : TEXCOORD1;
	float2 pos   : VPOS;
};

float aa_coverage(float dist)
{
	float width = max(fwidth(dist), 1.0);
	return smoothstep(0.5 * width, -0.5 * width, dist);
}

float mgfx_css_blur_profile(float distancePx, float blurPx, float falloff)
{
	float blur = max(blurPx, 0.001);
	float hardness = max(falloff, 0.35);
	float sigma = max(blur * rsqrt(hardness) * 0.72, 0.35);
	float t = max(distancePx, 0.0) / sigma;
	return exp2(-0.72134752 * t * t);
}

float mgfx_css_outer_effect(float dist, float blurPx, float falloff)
{
	return mgfx_css_blur_profile(max(dist, 0.0), blurPx, falloff) * (1.0 - aa_coverage(dist));
}

float mgfx_css_shadow_effect(float dist, float blurPx, float falloff)
{
	return mgfx_css_blur_profile(max(dist, 0.0), blurPx, falloff);
}

float mgfx_css_inner_effect(float depth, float blurPx, float falloff)
{
	return mgfx_css_blur_profile(max(depth, 0.0), blurPx, falloff);
}

float mgfx_css_combine_effect(float accumulated, float contribution)
{
	float a = saturate(accumulated);
	float b = saturate(contribution);
	return 1.0 - (1.0 - a) * (1.0 - b);
}

float4 mgfx_gradient_lut(float t)
{
	float u = saturate(t);
	float3 rgb = tex2D(Tex1, float2(u, 0.25)).rgb;
	float alpha = tex2D(Tex1, float2(u, 0.75)).r;
	return float4(rgb, alpha);
}

float4 mgfx_gradient_lut_conic(float rawT)
{
	float t = frac(rawT);
	float4 color = mgfx_gradient_lut(t);
	float seamWidth = min(max(fwidth(rawT) * 1.5, 0.0005), 0.02);
	float seamDist = min(t, 1.0 - t);

	if (seamDist < seamWidth)
	{
		float4 seamColor = (mgfx_gradient_lut(0.0) + mgfx_gradient_lut(1.0)) * 0.5;
		color = lerp(seamColor, color, smoothstep(0.0, seamWidth, seamDist));
	}

	return color;
}

float4 mgfx_fill(float2 uv, float4 baseColor)
{
	if (FILL_KIND < 0.5)
		return FILL_COLOR_B;

	float t = 0.0;

	if (FILL_KIND < 1.5)
	{
		float2 a = FILL_PARAMS.xy;
		float2 b = FILL_PARAMS.zw;
		float2 ab = b - a;
		t = saturate(dot(uv - a, ab) / max(dot(ab, ab), 0.0001));
	}
	else if (FILL_KIND < 2.5)
	{
		float2 radialScale = SIZE / max(min(SIZE.x, SIZE.y), 0.0001);
		t = saturate(length((uv - FILL_PARAMS.xy) * radialScale) / max(FILL_PARAMS.z, 0.0001));
	}
	else
	{
		float angle = atan2(uv.y - FILL_PARAMS.y, uv.x - FILL_PARAMS.x);
		return mgfx_gradient_lut_conic(angle / 6.28318530718 + 0.5 + FILL_PARAMS.z);
	}

	return mgfx_gradient_lut(t);
}

float4 compose_shape(float dist, float2 uv, float4 baseColor)
{
	float outer = aa_coverage(dist);
	float borderMask = 0.0;
	if (STROKE_WIDTH > 0.0 && STROKE_COLOR.a > 0.0)
		borderMask = aa_coverage(abs(dist) - STROKE_WIDTH * 0.5);

	float fillMask = outer * (1.0 - borderMask);
	float4 fillColor = mgfx_fill(uv, baseColor);

	float fillAlpha = fillColor.a * fillMask;
	float strokeAlpha = STROKE_COLOR.a * borderMask;
	float alpha = fillAlpha + strokeAlpha;
	if (alpha <= 0.001)
		discard;

	float3 rgb = (fillColor.rgb * fillAlpha + STROKE_COLOR.rgb * strokeAlpha) / alpha;

	return float4(saturate(rgb), saturate(alpha));
}

#endif
