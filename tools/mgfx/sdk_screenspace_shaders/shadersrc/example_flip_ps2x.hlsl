// Example shader that flips the screen horizontally

#include "common.hlsl"

float4 main( PS_INPUT i ) : COLOR
{
    float2 uv = i.uv;
    uv.x = 1.0 - uv.x;
	return tex2D(TexBase, uv);
}
