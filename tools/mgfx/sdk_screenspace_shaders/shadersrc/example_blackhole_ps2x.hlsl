// Example shader that tints dark areas harshly,
// as the player approaches closer to a target

#include "common.hlsl"

// Instead of PlayerOrigin you can also use the shader's EyePosition (see common.hlsl)
#define PlayerOrigin   Constants0.xyz

#define TargetOrigin   Constants1.xyz
#define TargetRadius   Constants1.w
#define TargetColor    Constants2.xyz

float Luminance(float3 color)
{
    return dot(color, float3(0.299, 0.587, 0.114));
}

float4 main( PS_INPUT i ) : COLOR
{
    float distance = length(PlayerOrigin - TargetOrigin);
    float intensity = saturate(1.0 - (distance / TargetRadius));

    float4 color = tex2D(TexBase, i.uv);

	// tint darker areas only
	float luminance = Luminance(color.rgb);
    float3 color_tint = lerp(color.xyz, TargetColor, intensity * step(luminance, 0.5));

	return float4(color_tint, color.a);
}
