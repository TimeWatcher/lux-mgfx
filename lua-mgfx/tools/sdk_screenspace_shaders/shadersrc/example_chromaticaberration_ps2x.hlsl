// Chromatic Aberration shader

#include "common.hlsl"

float4 main( PS_INPUT i ) : COLOR
{
	float2 uv = i.uv;

    float2 d = abs((uv - 0.5) * 2.0);
    d = pow(d, float2(2.0, 2.0));

    float4 r = tex2D(TexBase, uv - d * 0.015);
    float4 g = tex2D(TexBase, uv);
    float4 b = tex2D(TexBase, uv + d * 0.015);

    return float4(r.r, g.g, b.b, 1.0);
}
