#include "mgfx_roundrect_common.hlsl"

#define PROGRESS_PACKED EXTRA1.z
#define PROGRESS_RADIUS_PACKED EXTRA1.w
#define FILL_COLOR_A EXTRA2

float progress_inset()
{
	return floor(PROGRESS_PACKED * 0.5 + 0.001);
}

float progress_value()
{
	return saturate(PROGRESS_PACKED - progress_inset() * 2.0);
}

float progress_stroke_width()
{
	return floor(PROGRESS_RADIUS_PACKED / 256.0 + 0.001);
}

float progress_radius()
{
	return PROGRESS_RADIUS_PACKED - progress_stroke_width() * 256.0;
}

float4 main(PS_INPUT i) : COLOR
{
	float2 pos = i.uv * SIZE;
	float radius = progress_radius();
	float strokeWidth = progress_stroke_width();
	float inset = progress_inset();
	float value = progress_value();

	float trackDist = sd_roundrect(pos - SIZE * 0.5, SIZE * 0.5, radius);
	float outer = aa_coverage(trackDist);
	if (outer <= 0.001)
		discard;

	float inner = 1.0;
	if (strokeWidth > 0.0 && STROKE_COLOR.a > 0.0)
		inner = aa_coverage(trackDist + strokeWidth);

	float trackMask = outer * inner;
	float strokeMask = outer * (1.0 - inner);

	float2 fillArea = max(SIZE - inset * 2.0, float2(0.0, 0.0));
	float fillW = fillArea.x * value;
	float fillMask = 0.0;
	float4 fillColor = FILL_COLOR_A;

	if (fillW > 0.001 && fillArea.y > 0.001)
	{
		float2 fillSize = float2(fillW, fillArea.y);
		float2 fillCenter = float2(inset, inset) + fillSize * 0.5;
		float fillRadius = min(max(radius - inset, 0.0), min(fillSize.x, fillSize.y) * 0.5);
		float fillDist = sd_roundrect(pos - fillCenter, fillSize * 0.5, fillRadius);
		fillMask = aa_coverage(fillDist) * inner;

		float t = saturate((pos.x - inset) / max(fillW, 0.0001));
		fillColor = mgfx_gradient_lut(t);
	}

	float4 trackColor = float4(lerp(i.color.rgb * 0.65, i.color.rgb, saturate(i.uv.y)), i.color.a);
	float trackAlpha = trackColor.a * trackMask;
	float fillAlpha = fillColor.a * fillMask;
	float strokeAlpha = STROKE_COLOR.a * strokeMask;

	float3 rgb = trackColor.rgb * trackAlpha;
	float alpha = trackAlpha;

	rgb = rgb * (1.0 - fillAlpha) + fillColor.rgb * fillAlpha;
	alpha = alpha * (1.0 - fillAlpha) + fillAlpha;

	rgb = rgb * (1.0 - strokeAlpha) + STROKE_COLOR.rgb * strokeAlpha;
	alpha = alpha * (1.0 - strokeAlpha) + strokeAlpha;

	clip(alpha - 0.001);
	return float4(saturate(rgb / max(alpha, 0.0001)), saturate(alpha));
}
