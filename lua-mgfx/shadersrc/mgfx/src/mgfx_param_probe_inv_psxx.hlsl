#include "mgfx_common.hlsl"

float4 probe_inv_row(float y)
{
	if (y < 0.25)
		return AUX0;
	if (y < 0.5)
		return AUX1;
	if (y < 0.75)
		return AUX2;
	return AUX3;
}

float4 main(PS_INPUT i) : COLOR
{
	float4 row = saturate(probe_inv_row(i.uv.y));
	float gridX = step(0.985, frac(i.uv.x * 8.0));
	float gridY = step(0.94, frac(i.uv.y * 4.0));
	float grid = saturate(gridX + gridY) * 0.2;
	row.rgb = lerp(row.rgb, float3(0.0, 0.0, 0.0), grid);
	clip(row.a - 0.001);
	return row;
}
