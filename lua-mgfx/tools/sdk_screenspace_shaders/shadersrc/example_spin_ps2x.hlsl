// Example shader that displays a moving, spinning and textured square on the screen
// Adapted from https://www.shadertoy.com/view/clXyWB

#include "common.hlsl"

#define TAU 6.2831853

#define Time Constants0.x

float4 main( PS_INPUT i ) : COLOR
{
	float2 uv = i.uv - 0.5;
    float aspect = TexBaseSize.x / TexBaseSize.y;

    uv.x += (abs(fmod(Time * 0.5, 4.0) - 2.0) - 1.0) * 0.5625;
    uv.y += (abs(fmod(Time / aspect, 4.0) - 2.0) - 1.0) * (aspect - 0.3333333);

    float3 dir = normalize(float3(uv, 1.0));
    float3 norm = float3(sin(Time * TAU * 0.25), 0.0, cos(Time * TAU * 0.25));

    uv.x /= norm.z;
    uv /= uv.x * norm.x + 2.0;
    uv *= 6.0;

    uv.x /= aspect;

    float4 col;
    if (uv.x < -1.0 || uv.x > 1.0 || uv.y < -1.0 || uv.y > 1.0)
	{
		col = float4(0.0, 0.0, 0.0, 0.0);
	}
    else
	{
		float4 pix = tex2D(Tex1, uv * 0.5 + 0.5);
		float alpha = pix.w;
		col = pix * sqrt(abs(dot(dir, norm)));
		col.w = alpha;
	}

	return col;
}
