#include "mgfx_common.hlsl"
#include "mgfx_mask_common.hlsl"

#define CLIP_SCREEN_BOUNDS EXTRA0
#define CLIP_SIZE EXTRA1.xy
#define CLIP_KIND_PACKED EXTRA1.z
#define CLIP_RADIUS EXTRA1.w
#define CLIP_MASK_UV EXTRA2

float4 main(PS_INPUT i) : COLOR
{
	float invert = step(128.0, CLIP_KIND_PACKED);
	float kind = CLIP_KIND_PACKED - invert * 128.0;
	float2 shapeSize = max(CLIP_SIZE, float2(1.0, 1.0));
	float2 clipUVSize = max(CLIP_SCREEN_BOUNDS.zw, float2(0.000001, 0.000001));
	float2 localUV = i.uv;
	float coverage;

	if (kind < 9.5)
	{
		float dist = mgfx_mask_procedural_dist(localUV, shapeSize, kind, CLIP_RADIUS, CLIP_MASK_UV);
		dist = lerp(dist, -dist, invert);
		coverage = aa_coverage(dist);
		if (invert > 0.5)
		{
			float2 p = localUV * shapeSize;
			float2 center = shapeSize * 0.5;
			coverage *= aa_coverage(mgfx_mask_sd_roundrect(p - center, center, 0.0));
		}
	}
	else
	{
		// Custom coverage carries its own antialiased bounds plus a transparent
		// border of up to one pixel per available side. Do not multiply it by
		// another rectangular coverage:
		// that clips vector AA when the recorded shape approaches the Clip bounds.
		// localUV intentionally extends into the composite bleed quad so the
		// transparent raster border, rather than a hard clamp, terminates coverage.
		float2 maskUV = lerp(CLIP_MASK_UV.xy, CLIP_MASK_UV.zw, localUV);
		coverage = tex2D(Tex2, maskUV).a;
	}

	float2 screenUV = CLIP_SCREEN_BOUNDS.xy + localUV * clipUVSize;
	float4 beforeColor = tex2D(Tex3, screenUV);
	float4 afterColor = tex2D(Tex1, screenUV);
	return lerp(beforeColor, afterColor, saturate(coverage));
}
