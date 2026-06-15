// Template shader that does nothing interesting

// This contains parameters, etc that all shaders have available
// All shaders should include this
#include "common.hlsl"

// entry point
float4 main( PS_INPUT i ) : COLOR
{
	// copy each framebuffer pixel 1:1 (effectively does nothing)
	float4 result = tex2D(TexBase, i.uv.xy);

	return result;
}
