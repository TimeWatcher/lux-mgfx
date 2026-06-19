// Example shader that displays pixels as ASCII characters
// Adapted from https://www.shadertoy.com/view/lssGDj

#include "common.hlsl"

float character(int n, float2 p)
{
	p = floor(p * float2(-4.0, -4.0) + 2.5);
	if (clamp(p.x, 0.0, 4.0) == p.x)
	{
		if (clamp(p.y, 0.0, 4.0) == p.y)
		{
			int a = int(round(p.x) + 5.0 * round(p.y));
			int s = n / (int)pow(2, a); // n >> a
			if ((s % 2) == 1)			// & 1
				return 1.0;
		}
	}
	return 0.1; // 0.0 is too dark
}

float4 main( PS_INPUT i ) : COLOR
{
	// see below for why this is needed
	// https://www.gamedev.net/blogs/entry/1848486-understanding-half-pixel-and-half-texel-offsets/
	float2 half_pix = float2(0.5, 0.5) * TexBaseSize;

	float2 pix = (i.uv + half_pix) * (1.0 / TexBaseSize);
	float3 col = tex2D(TexBase, floor(pix / 8.0) * 8.0 / (1.0 / TexBaseSize)).rgb;

	float gray = 0.3 * col.r + 0.59 * col.g + 0.11 * col.b;
	int n =	 4096;
	if (gray > 0.2) n = 65600;    // :
	if (gray > 0.3) n = 163153;   // *
	if (gray > 0.4) n = 15255086; // o
	if (gray > 0.5) n = 13121101; // &
	if (gray > 0.6) n = 15252014; // 8
	if (gray > 0.7) n = 13195790; // @
	if (gray > 0.8) n = 11512810; // #

	float2 p = fmod(pix / 4.0, 2.0) - float2(1.0, 1.0);
	return float4(col * character(n, p), 1.0);
}
