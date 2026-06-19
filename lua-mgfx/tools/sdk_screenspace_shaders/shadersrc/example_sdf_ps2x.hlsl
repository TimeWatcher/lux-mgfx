// Example shader that demonstrates SDF (Signed Distance Field) rendering for the 'A' glyph
// To learn more about this technique, read Valve's paper:
// https://steamcdn-a.akamaihd.net/apps/valve/2007/SIGGRAPH2007_AlphaTestedMagnification.pdf
// The left side shows SDF (Valve's approach)
// The right side shows MSDF, an improvement for SDF that preserves sharp corners
// See this for more info: https://github.com/Chlumsky/msdfgen
// Code is based on the sample from the above link

#include "common.hlsl"

static const float4 foreground_color = float4(1.0, 1.0, 1.0, 1.0);
static const float4 background_color = float4(0.0, 0.0, 0.0, 0.0);

#define ScreenPxRange Constants0.x

float median(float3 v)
{
    return max(min(v.x, v.y), min(max(v.x, v.y), v.z));
}

float screen_px_range(float2 uv, float2 tex_resolution)
{
	// The computation for this value is commented out
	// Unfortunately, derivative functions like fwidth are not available on shader model 2.0b
	// Therefore this value needs to be hardcoded depending on the font scale
	//float px_range = 2.0;
	//float2 range = float2(px_range, px_range) / tex_resolution;
	//float2 screen_tex_size = float2(1.0, 1.0) / fwidth(uv);
	//return max(dot(range, screen_tex_size) * 0.5, 1.0);
	return ScreenPxRange;
}

float4 main( PS_INPUT i ) : COLOR
{
	// https://www.gamedev.net/blogs/entry/1848486-understanding-half-pixel-and-half-texel-offsets/
	// this offset is not needed, but it fixes an annoying stray line in the middle of the screen
	float2 half_pix = float2(0.5, 0.5) * TexBaseSize;
    float2 uv = i.uv + half_pix;

	uv.x *= 2.0;

	// left - SDF
    if (i.uv.x < 0.5)
    {
        float signed_dist = tex2D(Tex1, uv).r;
        float screen_px_distance = screen_px_range(uv, 1.0 / Tex1Size) * (signed_dist - 0.5);
        float opacity = clamp(screen_px_distance + 0.5, 0.0, 1.0);
        return lerp(background_color, foreground_color, opacity);
    }
	 // right - MSDF
    else
    {
        float3 msd = tex2D(Tex2, uv).rgb;
        float signed_dist = median(msd);
        float screen_px_distance = screen_px_range(uv, 1.0 / Tex2Size) * (signed_dist - 0.5);
        float opacity = clamp(screen_px_distance + 0.5, 0.0, 1.0);
        return lerp(background_color, foreground_color, opacity);
    }
}
