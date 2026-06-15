#include "mgfx_common.hlsl"

#define SEG_FILL_B EXTRA0
#define SEG_TRACK EXTRA1
#define SEG_SIZE EXTRA2.xy
#define SEG_COUNT EXTRA2.z
#define SEG_GAP EXTRA2.w
#define SEG_VALUE EXTRA3.x
#define SEG_RADIUS EXTRA3.y

float sd_roundrect(float2 p, float2 halfSize, float radius)
{
	float2 q = abs(p) - halfSize + radius;
	return min(max(q.x, q.y), 0.0) + length(max(q, 0.0)) - radius;
}

float4 main(PS_INPUT i) : COLOR
{
	float count = max(1.0, floor(SEG_COUNT + 0.5));
	float gap = max(0.0, SEG_GAP);
	float segW = (SEG_SIZE.x - gap * (count - 1.0)) / count;
	if (segW <= 0.001 || SEG_SIZE.y <= 0.001)
		discard;

	float pitch = segW + gap;
	float2 pos = i.uv * SEG_SIZE;
	float idx = floor((pos.x + gap * 0.5) / pitch);
	if (idx < 0.0 || idx >= count)
		discard;

	float2 center = float2(idx * pitch + segW * 0.5, SEG_SIZE.y * 0.5);
	float radius = min(max(SEG_RADIUS, 0.0), min(segW, SEG_SIZE.y) * 0.5);
	float dist = sd_roundrect(pos - center, float2(segW, SEG_SIZE.y) * 0.5, radius);
	float coverage = aa_coverage(dist);
	if (coverage <= 0.001)
		discard;

	float activeCount = floor(saturate(SEG_VALUE) * count + 0.0001);
	float active = step(idx + 1.0, activeCount);
	float t = count <= 1.0 ? 1.0 : idx / (count - 1.0);
	float4 fill = mgfx_gradient_lut(t);
	float4 color = lerp(SEG_TRACK, fill, active);
	float alpha = color.a * coverage;
	clip(alpha - 0.001);
	return float4(saturate(color.rgb), saturate(alpha));
}
