#include "mgfx_roundrect_common.hlsl"

#define FILL_COLOR_A EXTRA2
#define PROGRESS_FX_PACKED EXTRA1.z
#define PROGRESS_LAYOUT_PACKED EXTRA1.w

#define FX_GLOW 1.0
#define FX_SHEEN 2.0
#define FX_MARKER 4.0

float fx_curve()
{
	return floor(PROGRESS_FX_PACKED / 256.0 + 0.001);
}

float fx_base_packed()
{
	return PROGRESS_FX_PACKED - fx_curve() * 256.0;
}

float fx_ticks()
{
	return floor(fx_base_packed() / 8.0 + 0.001);
}

float fx_flags()
{
	return floor(fx_base_packed() - fx_ticks() * 8.0 + 0.001);
}

float fx_value()
{
	float rest = fx_base_packed() - fx_ticks() * 8.0;
	return saturate((rest - fx_flags()) * 2.0);
}

float fx_flag(float flags, float bit)
{
	float bucket = floor(flags / bit + 0.001);
	return bucket - floor(bucket * 0.5) * 2.0;
}

float fx_radius()
{
	return PROGRESS_LAYOUT_PACKED - floor(PROGRESS_LAYOUT_PACKED / 256.0 + 0.001) * 256.0;
}

float fx_stroke_width()
{
	float packed = floor(PROGRESS_LAYOUT_PACKED / 256.0 + 0.001);
	return packed - floor(packed / 16.0 + 0.001) * 16.0;
}

float fx_inset()
{
	return floor(PROGRESS_LAYOUT_PACKED / 4096.0 + 0.001);
}

void blend_over(inout float3 rgb, inout float alpha, float3 srcRgb, float srcAlpha)
{
	rgb = rgb * (1.0 - srcAlpha) + srcRgb * srcAlpha;
	alpha = alpha * (1.0 - srcAlpha) + srcAlpha;
}

float rect_band(float p, float start, float finish)
{
	return aa_coverage(start - p) * aa_coverage(p - finish);
}

float4 main(PS_INPUT i) : COLOR
{
	float2 pos = i.uv * SIZE;
	float radius = fx_radius();
	float strokeWidth = fx_stroke_width();
	float inset = fx_inset();
	float value = fx_value();
	float flags = fx_flags();
	float ticks = fx_ticks();

	float trackDist = sd_roundrect(pos - SIZE * 0.5, SIZE * 0.5, radius);
	float outer = aa_coverage(trackDist);
	float strokeMask = 0.0;
	if (strokeWidth > 0.0 && STROKE_COLOR.a > 0.0)
		strokeMask = aa_coverage(abs(trackDist) - strokeWidth * 0.5);

	float trackMask = outer * (1.0 - strokeMask);

	float2 fillArea = max(SIZE - inset * 2.0, float2(0.0, 0.0));
	float fillW = fillArea.x * value;
	float fillMask = 0.0;
	float glowMask = 0.0;
	float sheenMask = 0.0;
	float markerMask = 0.0;
	float4 fillColor = FILL_COLOR_A;

	if (fillW > 0.001 && fillArea.y > 0.001)
	{
		float2 fillSize = float2(fillW, fillArea.y);
		float2 fillCenter = float2(inset, inset) + fillSize * 0.5;
		float fillRadius = min(max(radius - inset, 0.0), min(fillSize.x, fillSize.y) * 0.5);
		float fillDist = sd_roundrect(pos - fillCenter, fillSize * 0.5, fillRadius);
		fillMask = aa_coverage(fillDist) * (1.0 - strokeMask);

		float t = saturate((pos.x - inset) / max(fillW, 0.0001));
		fillColor = mgfx_gradient_lut(t, fx_curve(), i.pos);

		if (fx_flag(flags, FX_GLOW) > 0.5 && fillW > 4.0)
		{
			float2 glowSize = fillSize + float2(4.0, 4.0);
			float2 glowCenter = fillCenter;
			float glowRadius = min(fillRadius + 2.0, min(glowSize.x, glowSize.y) * 0.5);
			float glowDist = sd_roundrect(pos - glowCenter, glowSize * 0.5, glowRadius);
			glowMask = aa_coverage(glowDist) * trackMask * (1.0 - fillMask);
		}

		if (fx_flag(flags, FX_SHEEN) > 0.5 && fillW > 8.0)
		{
			float top = inset + 1.0;
			float bottom = min(inset + 1.0 + fillArea.y * 0.38, inset + fillArea.y);
			sheenMask = fillMask * rect_band(pos.y, top, bottom);
		}

		if (fx_flag(flags, FX_MARKER) > 0.5 && fillW > 5.0)
		{
			float mx = inset + fillW - 2.0;
			float xMask = rect_band(pos.x, mx, mx + 2.0);
			float yMask = rect_band(pos.y, 2.0, SIZE.y - 2.0);
			markerMask = xMask * yMask * trackMask;
		}
	}

	float tickMask = 0.0;
	if (ticks > 1.5)
	{
		float yMask = rect_band(pos.y, 3.0, SIZE.y - 3.0);
		for (int idx = 1; idx < 32; idx++)
		{
			if (idx < ticks)
			{
				float tx = SIZE.x * idx / ticks;
				tickMask = max(tickMask, (1.0 - smoothstep(0.45, 0.95, abs(pos.x - tx))) * yMask * trackMask);
			}
		}
	}

	float4 trackColor = float4(lerp(i.color.rgb * 0.65, i.color.rgb, saturate(i.uv.y)), i.color.a);
	float trackAlpha = trackColor.a * trackMask;
	float3 rgb = trackColor.rgb * trackAlpha;
	float alpha = trackAlpha;

	blend_over(rgb, alpha, FILL_COLOR_B.rgb, FILL_COLOR_B.a * 0.13 * glowMask);
	blend_over(rgb, alpha, STROKE_COLOR.rgb, min(STROKE_COLOR.a * 0.22, 0.06) * tickMask);
	blend_over(rgb, alpha, fillColor.rgb, fillColor.a * fillMask);
	blend_over(rgb, alpha, float3(1.0, 1.0, 1.0), 0.165 * sheenMask);
	blend_over(rgb, alpha, float3(1.0, 1.0, 1.0), 0.376 * markerMask);
	blend_over(rgb, alpha, STROKE_COLOR.rgb, STROKE_COLOR.a * strokeMask);

	clip(alpha - 0.001);
	return float4(saturate(rgb / max(alpha, 0.0001)), saturate(alpha));
}
