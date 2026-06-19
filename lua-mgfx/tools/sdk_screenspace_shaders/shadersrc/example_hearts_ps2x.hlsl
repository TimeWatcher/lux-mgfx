// Example shader that generates an infinite tunnel of rainbow hearts
// Adapated from https://www.shadertoy.com/view/4cyfRy

#include "common.hlsl"

#define PI 3.14159265359

#define Time Constants0.x

float myLog(float2 uv, float2 center)
{
    float2 offset = uv - center;
    return 6.0 * log(length(offset));
}

float myAtan2(float2 uv, float2 center)
{
    float2 offset = uv - center;
    return 6.0 * atan2(offset.y, offset.x);
}

float funPattern(float logVal, float atanVal, float t)
{
    return cos(cos(logVal - t) + 2.0 * cos(atanVal + t - abs(sin(logVal - t))));
}

// Convert hue to RGB (HSB to RGB helper function)
float3 hsb2rgb(float h, float s, float b)
{
    float3 c = float3(h, s, b);
    float k = fmod(c.x * 6.0, 6.0);
    float f = k - floor(k);
    float p = c.z * (1.0 - c.y);
    float q = c.z * (1.0 - f * c.y);
    float t = c.z * (1.0 - (1.0 - f) * c.y);

    if (k < 1.0) return float3(c.z, t, p);
    if (k < 2.0) return float3(q, c.z, p);
    if (k < 3.0) return float3(p, c.z, t);
    if (k < 4.0) return float3(p, q, c.z);
    if (k < 5.0) return float3(t, p, c.z);
    return float3(c.z, p, q);
}

float4 main( PS_INPUT i ) : COLOR
{
	float2 uv = i.uv - 0.5;

	// Aspect ratio correction
	uv.x *= 1.0 / (TexBaseSize.x / TexBaseSize.y);

    float2 center = float2(0.0, 0.0);

    // Compute pattern values
    float logVal = myLog(uv, center);
    float atanVal = myAtan2(uv, center);
    float patternValue = funPattern(logVal, atanVal, Time);

    // Assign color based on patternValue
    float3 color;
	float alpha;
    if (patternValue < 0.0)
	{
		// Map [-1, 0] to [0, 1]
        float hue = lerp(0.0, 1.0, (patternValue + 1.0) / 1.0);
        color = hsb2rgb(hue, 1.0, 1.0);
		alpha = 1.0;
    }
	else
	{
        color = float3(0.15, 0.15, 0.15);
		alpha = 0.0;
    }

    return float4(color, alpha);
}
