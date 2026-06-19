// Example shader that displays the depth buffer
// NOTE: the depth buffer in Source only extends 192 units!

#include "common.hlsl"

float4 main( PS_INPUT i ) : COLOR
{
    float4 color = tex2D(TexBase, i.uv);
	float depth = 1.0 - color.w;
	return float4(depth, depth, depth, 1.0);
}
