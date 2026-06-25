#include "mgfx_common.hlsl"

#define TEXT_ATLAS_RECT AUX0
#define TEXT_COLOR_A AUX1
#define TEXT_COLOR_B AUX2
#define TEXT_GRADIENT AUX3

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

float4 main(PS_INPUT i) : COLOR
{
	float alpha = saturate(pow(filtered_face_alpha(i.uv), 0.98) * 1.006);
	clip(alpha - 0.001);

	float2 rectMin = TEXT_ATLAS_RECT.xy;
	float2 rectMax = TEXT_ATLAS_RECT.zw;
	float2 localUv = saturate((i.uv - rectMin) / max(rectMax - rectMin, float2(0.00001, 0.00001)));

	float2 a = TEXT_GRADIENT.xy;
	float2 b = TEXT_GRADIENT.zw;
	float2 ab = b - a;
	float t = saturate(dot(localUv - a, ab) / max(dot(ab, ab), 0.0001));
	float4 face = mgfx_gradient_lut(t);

	return float4(saturate(face.rgb * i.color.rgb), saturate(alpha * face.a * i.color.a));
}
