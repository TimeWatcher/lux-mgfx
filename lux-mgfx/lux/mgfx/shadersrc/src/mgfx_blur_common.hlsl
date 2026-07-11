#ifndef MGFX_BLUR_COMMON_HLSL
#define MGFX_BLUR_COMMON_HLSL

#include "mgfx_common.hlsl"

#ifndef BLUR_VERTICAL
#define BLUR_VERTICAL EXTRA0.x
#endif

#ifndef BLUR_INTENSITY
#define BLUR_INTENSITY EXTRA0.y
#endif

static const float w[8] = {0.026109, 0.034202, 0.043219, 0.052683, 0.061948, 0.070266, 0.076883, 0.081149};
static const float o[8] = {15.5, 13.5, 11.5, 9.5, 7.5, 5.5, 3.5, 1.5};

float3 mgfx_blur(float2 uv)
{
#if MGFX_BLUR_SAMPLE_ONLY
	return tex2D(TexBase, uv).rgb;
#else
	float2 dir = BLUR_VERTICAL > 0.5 ? float2(0.0, 1.0) : float2(1.0, 0.0);
	float3 color = float3(0.0, 0.0, 0.0);

	[unroll] for (int i = 0; i < 8; i++)
	{
		color += w[i] * tex2D(TexBase, uv - TexBaseSize * (o[i] * BLUR_INTENSITY * dir)).rgb;
	}

	color += 0.041312 * tex2D(TexBase, uv).rgb;

	[unroll] for (int j = 7; j >= 0; j--)
	{
		color += w[j] * tex2D(TexBase, uv + TexBaseSize * (o[j] * BLUR_INTENSITY * dir)).rgb;
	}

	return color / 0.93423;
#endif
}

#endif
