#include "mgfx_common.hlsl"

#define TEXT_STROKE_COLOR AUX0
#define TEXT_GLOW_COLOR AUX1
#define TEXT_SHADOW_COLOR AUX2
#define TEXT_PARAMS AUX3
#define TEXT_STROKE_WIDTH TEXT_PARAMS.x
#define TEXT_GLOW_WIDTH TEXT_PARAMS.y
#define TEXT_EFFECT_PACK TEXT_PARAMS.z
#define TEXT_SHADOW_PACK TEXT_PARAMS.w
#define TEXT_ATLAS_RECT EXTRA0
#define TEXT_ATLAS_TEXEL float2(1.0 / 2048.0, 1.0 / 1024.0)

static const float2 DIR16[16] = {
	float2(1.0000, 0.0000),
	float2(0.9239, 0.3827),
	float2(0.7071, 0.7071),
	float2(0.3827, 0.9239),
	float2(0.0000, 1.0000),
	float2(-0.3827, 0.9239),
	float2(-0.7071, 0.7071),
	float2(-0.9239, 0.3827),
	float2(-1.0000, 0.0000),
	float2(-0.9239, -0.3827),
	float2(-0.7071, -0.7071),
	float2(-0.3827, -0.9239),
	float2(0.0000, -1.0000),
	float2(0.3827, -0.9239),
	float2(0.7071, -0.7071),
	float2(0.9239, -0.3827)
};

float glyph_coverage(float4 texel)
{
	float a = saturate(texel.a);
	float rgb = saturate(max(max(texel.r, texel.g), texel.b));
	if (a <= 0.001)
		return rgb;
	if (rgb <= 0.001)
		return a;
	return min(a, rgb);
}

float atlas_rect_mask(float2 uv)
{
	float2 rectMin = TEXT_ATLAS_RECT.xy;
	float2 rectMax = TEXT_ATLAS_RECT.zw;
	float2 inside = step(rectMin, uv) * step(uv, rectMax);
	return inside.x * inside.y;
}

float sample_alpha(float2 uv)
{
	return glyph_coverage(tex2D(TexBase, uv)) * atlas_rect_mask(uv);
}

float4 sample_texel(float2 uv)
{
	float4 texel = tex2D(TexBase, uv);
	float mask = atlas_rect_mask(uv);
	texel.rgb *= mask;
	texel.a = glyph_coverage(texel) * mask;
	return texel;
}

float4 dilate_texel(float2 uv, float radius)
{
	float2 step = TEXT_ATLAS_TEXEL * max(radius, 0.5);
	float4 best = sample_texel(uv);
	float bestA = best.a;

	[unroll] for (int i = 0; i < 16; i++)
	{
		float4 t = sample_texel(uv + DIR16[i] * step);
		if (t.a > bestA)
		{
			best = t;
			bestA = t.a;
		}
	}

	float2 halfStep = step * 0.5;
	[unroll] for (int j = 0; j < 16; j += 2)
	{
		float4 t2 = sample_texel(uv + DIR16[j] * halfStep);
		if (t2.a > bestA)
		{
			best = t2;
			bestA = t2.a;
		}
	}

	return best;
}

float erode_alpha(float2 uv, float radius)
{
	float2 step = TEXT_ATLAS_TEXEL * max(radius, 0.5);
	float a = sample_alpha(uv);

	[unroll] for (int i = 0; i < 16; i++)
	{
		a = min(a, sample_alpha(uv + DIR16[i] * step));
	}

	float2 halfStep = step * 0.5;
	[unroll] for (int j = 0; j < 16; j += 2)
	{
		a = min(a, sample_alpha(uv + DIR16[j] * halfStep));
	}

	return saturate(a);
}

float4 apply_weight_fx(float2 uv, float4 texel, float weightFx)
{
	if (weightFx > 0.001)
	{
		float amount = saturate(weightFx / 1.75);
		float4 expanded = dilate_texel(uv, max(weightFx, 0.5));
		float targetAlpha = max(texel.a, expanded.a);
		float newAlpha = lerp(texel.a, targetAlpha, amount);
		float outside = 1.0 - smoothstep(0.08, 0.82, texel.a);
		float colorTake = saturate(outside * amount * smoothstep(texel.a + 0.001, texel.a + 0.45, expanded.a));
		return float4(lerp(texel.rgb, expanded.rgb, colorTake), saturate(newAlpha));
	}

	if (weightFx < -0.001)
	{
		float amount = saturate((-weightFx) / 1.35);
		texel.a = lerp(texel.a, erode_alpha(uv, max(-weightFx, 0.5)), amount);
	}

	return texel;
}

float3 clean_atlas_rgb(float4 texel)
{
	float a = saturate(texel.a);
	if (a <= 0.001)
		return texel.rgb;

	float maxRgb = max(max(texel.r, texel.g), texel.b);
	float3 unpremul = texel.rgb / max(a, 0.001);

	// Native glyphs and bilinear filtering can leave premultiplied RGB in the
	// atlas edge pixels. Keep already-straight samples untouched, but repair the
	// common premultiplied edge so the text face stays color-pure.
	float straight = smoothstep(a + 0.025, a + 0.180, maxRgb);
	return saturate(lerp(unpremul, texel.rgb, straight));
}

float dilate_alpha(float2 uv, float radius)
{
	float2 step = TEXT_ATLAS_TEXEL * max(radius, 0.5);
	float a = sample_alpha(uv);

	[unroll] for (int i = 0; i < 16; i++)
	{
		a = max(a, sample_alpha(uv + DIR16[i] * step));
	}

	float2 halfStep = step * 0.5;
	[unroll] for (int j = 0; j < 16; j += 2)
	{
		a = max(a, sample_alpha(uv + DIR16[j] * halfStep));
	}

	return a;
}

float blur_alpha_disk(float2 uv, float radius, float falloff)
{
	radius = max(radius, 0.5);
	falloff = max(falloff, 0.25);

	float accum = sample_alpha(uv);
	float total = 1.0;

	[unroll] for (int ring = 1; ring <= 4; ring++)
	{
		float t = ring / 4.0;
		float r = max(radius * t, 0.35);
		float weight = exp2(-2.88539008 * t * t * falloff);
		float2 step = TEXT_ATLAS_TEXEL * r;

		[unroll] for (int i = 0; i < 16; i++)
		{
			accum += sample_alpha(uv + DIR16[i] * step) * weight;
			total += weight;
		}
	}

	return saturate(accum / max(total, 0.0001));
}

float face_alpha(float alpha)
{
	alpha = saturate(alpha);
	return saturate(pow(alpha, 0.98) * 1.006);
}

float filtered_face_alpha(float2 uv)
{
	float2 dx = ddx(uv);
	float2 dy = ddy(uv);
	float a = sample_alpha(uv) * 0.50;
	a += sample_alpha(uv + dx * 0.35) * 0.125;
	a += sample_alpha(uv - dx * 0.35) * 0.125;
	a += sample_alpha(uv + dy * 0.35) * 0.125;
	a += sample_alpha(uv - dy * 0.35) * 0.125;
	return saturate(a);
}

float outside_from_fill(float alpha)
{
	// Text effects must behave like layer styles: stroke/glow/shadow sit outside
	// the glyph face and must not dirty the antialiased face coverage.
	return saturate(1.0 - smoothstep(0.025, 0.420, saturate(alpha)));
}

float stroke_coverage(float2 uv, float baseAlpha, float width, float softness)
{
	if (width <= 0.001)
		return 0.0;

	softness = saturate(softness);
	float outer = dilate_alpha(uv, max(width, 0.5));
	if (width > 1.25)
		outer = max(outer, dilate_alpha(uv, width * 0.5));

	float softBlur = blur_alpha_disk(uv, max(width + softness * 1.15, 0.65), lerp(1.45, 0.92, softness));
	float spread = max(outer, softBlur * lerp(1.25, 1.85, softness));
	float ring = saturate(spread - baseAlpha * lerp(0.96, 0.72, softness));
	float mask = smoothstep(0.030, lerp(0.62, 0.38, softness), ring);
	return saturate(mask * outside_from_fill(baseAlpha));
}

float glow_coverage(float2 uv, float baseAlpha, float width, float falloff)
{
	if (width <= 0.001)
		return 0.0;

	float blur = blur_alpha_disk(uv, width, falloff);
	float outside = outside_from_fill(baseAlpha);
	float glow = saturate(blur * lerp(1.85, 1.20, saturate(falloff / 3.25)));
	return saturate(glow * outside);
}

void decode_effect_pack4(out float shadowBlur, out float glowFalloff, out float faceStrength, out float weightFx, out float faceEnabled)
{
	float packed = floor(TEXT_EFFECT_PACK + 0.5);
	float blurByte = floor(packed / 131072.0);
	float rest = packed - blurByte * 131072.0;
	float falloffByte = floor(rest / 2048.0);
	rest = rest - falloffByte * 2048.0;
	float faceByte = floor(rest / 64.0);
	float weightByte = rest - faceByte * 64.0;
	shadowBlur = blurByte * 0.5;
	glowFalloff = max(falloffByte / 8.0, 0.25);
	faceEnabled = step(0.5, faceByte);
	faceStrength = saturate((faceByte - 1.0) / 30.0);
	weightFx = weightByte / 63.0 * 4.0 - 2.0;
	if (abs(weightFx) < 0.04)
		weightFx = 0.0;
}

void decode_shadow_pack(out float2 shadowOffset, out float strokeSoftness)
{
	float packed = floor(TEXT_SHADOW_PACK + 0.5);
	float xb = floor(packed / 65536.0);
	float rest = packed - xb * 65536.0;
	float yb = floor(rest / 256.0);
	float softByte = rest - yb * 256.0;
	shadowOffset = float2(xb * 0.5 - 64.0, yb * 0.5 - 64.0);
	strokeSoftness = saturate(softByte / 255.0);
}

float shadow_coverage(float2 uv, float2 offset, float blur)
{
	float2 center = uv - offset * TEXT_ATLAS_TEXEL;
	blur = max(blur, 0.0);

	if (blur <= 0.5)
		return sample_alpha(center);

	float accum = sample_alpha(center);
	float total = 1.0;

	[unroll] for (int ring = 1; ring <= 4; ring++)
	{
		float t = ring / 4.0;
		float2 r = TEXT_ATLAS_TEXEL * max(blur * t, 0.35);
		float weight = exp2(-2.88539008 * t * t);

		accum += sample_alpha(center + float2( r.x, 0.0)) * weight;
		accum += sample_alpha(center + float2(-r.x, 0.0)) * weight;
		accum += sample_alpha(center + float2(0.0,  r.y)) * weight;
		accum += sample_alpha(center + float2(0.0, -r.y)) * weight;

		float2 d = r * 0.70710678;
		accum += sample_alpha(center + float2( d.x,  d.y)) * weight;
		accum += sample_alpha(center + float2(-d.x,  d.y)) * weight;
		accum += sample_alpha(center + float2( d.x, -d.y)) * weight;
		accum += sample_alpha(center + float2(-d.x, -d.y)) * weight;
		total += weight * 8.0;
	}

	return saturate(accum / max(total, 0.0001));
}

void blend_over(inout float3 premul, inout float alpha, float3 srcRgb, float srcAlpha)
{
	srcAlpha = saturate(srcAlpha);
	premul += srcRgb * srcAlpha * (1.0 - alpha);
	alpha += srcAlpha * (1.0 - alpha);
}

float3 shade_face(float2 uv, float3 rgb, float alpha, float strength)
{
	if (strength <= 0.001 || alpha <= 0.001)
		return rgb;

	float2 px = TEXT_ATLAS_TEXEL;
	float left = sample_alpha(uv - float2(px.x, 0.0));
	float right = sample_alpha(uv + float2(px.x, 0.0));
	float up = sample_alpha(uv - float2(0.0, px.y));
	float down = sample_alpha(uv + float2(0.0, px.y));
	float minN = min(min(left, right), min(up, down));
	float maxN = max(max(left, right), max(up, down));
	float edge = saturate((maxN - minN) * 1.10) * smoothstep(0.22, 0.94, alpha);
	float core = smoothstep(0.58, 1.0, alpha);

	float coreLift = core * (0.030 * strength);
	float edgeClean = edge * core * (0.012 * strength);

	rgb = lerp(rgb, float3(1.0, 1.0, 1.0), coreLift + edgeClean);
	return saturate(rgb);
}

float4 main(PS_INPUT i) : COLOR
{
	float4 atlas = sample_texel(i.uv);
	float shadowBlur = 0.0;
	float glowFalloff = 1.65;
	float faceStrength = 0.0;
	float weightFx = 0.0;
	float faceEnabled = 0.0;
	float2 shadowOffset = float2(0.0, 0.0);
	float strokeSoftness = 0.0;
	decode_effect_pack4(shadowBlur, glowFalloff, faceStrength, weightFx, faceEnabled);
	decode_shadow_pack(shadowOffset, strokeSoftness);
	atlas = apply_weight_fx(i.uv, atlas, weightFx);
	float glyphAlpha = face_alpha(filtered_face_alpha(i.uv));
	float4 fill = float4(saturate(i.color.rgb), saturate(glyphAlpha * i.color.a));
	fill.a = saturate(fill.a);
	fill.rgb = shade_face(i.uv, fill.rgb, fill.a, faceStrength);

	float strokeMask = 0.0;
	if (TEXT_STROKE_COLOR.a > 0.001 && TEXT_STROKE_WIDTH > 0.001)
		strokeMask = stroke_coverage(i.uv, glyphAlpha, TEXT_STROKE_WIDTH, strokeSoftness);

	float glowMask = 0.0;
	if (TEXT_GLOW_COLOR.a > 0.001 && TEXT_GLOW_WIDTH > 0.001)
		glowMask = glow_coverage(i.uv, saturate(glyphAlpha + strokeMask * 0.45), TEXT_GLOW_WIDTH, glowFalloff);

	float shadowMask = 0.0;
	if (TEXT_SHADOW_COLOR.a > 0.001)
	{
		shadowMask = shadow_coverage(i.uv, shadowOffset, shadowBlur) * outside_from_fill(glyphAlpha);
	}

	float3 premul = float3(0.0, 0.0, 0.0);
	float alpha = 0.0;

	blend_over(premul, alpha, TEXT_SHADOW_COLOR.rgb, TEXT_SHADOW_COLOR.a * shadowMask);
	blend_over(premul, alpha, TEXT_GLOW_COLOR.rgb, TEXT_GLOW_COLOR.a * glowMask);
	blend_over(premul, alpha, TEXT_STROKE_COLOR.rgb, TEXT_STROKE_COLOR.a * strokeMask);
	if (faceEnabled > 0.5)
		blend_over(premul, alpha, fill.rgb, fill.a);

	clip(alpha - 0.001);
	float3 outRgb = saturate(premul / max(alpha, 0.0001));
	return float4(saturate(outRgb), saturate(alpha));
}
