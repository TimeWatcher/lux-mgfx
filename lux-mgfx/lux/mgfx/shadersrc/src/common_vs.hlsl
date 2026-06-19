#ifndef MGFX_COMMON_VS_HLSL
#define MGFX_COMMON_VS_HLSL

const float4x4 cModelViewProj : register(c4);
const float4x4 cViewProj : register(c8);

struct VS_INPUT
{
	float3 pos   : POSITION;
	float4 color : COLOR0;
	float2 uv    : TEXCOORD0;
};

struct VS_OUTPUT
{
	float4 projPos : POSITION;
	float2 uv      : TEXCOORD0;
	float4 color   : TEXCOORD1;
};

#endif
