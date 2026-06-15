// Example shader that applies a RGB color distortion to the screen

#include "common.hlsl"

#define Time		Constants0.x
#define Intensity	Constants0.y
#define Distortion	Constants0.z
#define Speed       Constants0.w

float4 main( PS_INPUT i ) : COLOR
{
    float2 uv = i.uv;

    float glitch = sin(uv.y * 10.0 + Time * Speed) * Distortion * 0.005;
    float shift = sin(Time * Speed) * Intensity;

    uv.x += glitch;

    float4 result = tex2D(TexBase, uv);
    result.r = tex2D(TexBase, uv + float2(shift, 0)).r;
    result.g = tex2D(TexBase, uv + float2(-shift, shift)).g;
    result.b = tex2D(TexBase, uv + float2(0, -shift)).b;

    return result;
}
