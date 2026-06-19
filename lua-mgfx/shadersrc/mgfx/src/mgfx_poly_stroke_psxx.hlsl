const float4x4 MGFXExtraParams : register(c11);

#define EXTRA0 MGFXExtraParams[0]
#define EXTRA1 MGFXExtraParams[1]
#define EXTRA2 MGFXExtraParams[2]
#define EXTRA3 MGFXExtraParams[3]

#define VERT_0 EXTRA0.xy
#define VERT_1 EXTRA0.zw
#define VERT_2 EXTRA1.xy
#define VERT_3 EXTRA1.zw
#define STROKE_COLOR EXTRA2
#define SHAPE_SIZE EXTRA3.xy
#define STROKE_WIDTH EXTRA3.z
#define POLY_COUNT EXTRA3.w

struct PS_INPUT
{
	float2 uv    : TEXCOORD0;
	float4 color : TEXCOORD1;
	float2 pos   : VPOS;
};

float segment_dist(float2 p, float2 a, float2 b)
{
	float2 ab = b - a;
	float t = saturate(dot(p - a, ab) / max(dot(ab, ab), 0.0001));
	return length(p - (a + ab * t));
}

float4 main(PS_INPUT i) : COLOR
{
	float2 p = i.uv * SHAPE_SIZE;
	float d = segment_dist(p, VERT_0, VERT_1);
	d = min(d, segment_dist(p, VERT_1, VERT_2));

	if (POLY_COUNT < 3.5)
	{
		d = min(d, segment_dist(p, VERT_2, VERT_0));
	}
	else
	{
		d = min(d, segment_dist(p, VERT_2, VERT_3));
		d = min(d, segment_dist(p, VERT_3, VERT_0));
	}

	float width = max(STROKE_WIDTH, 0.0);
	float aa = max(fwidth(d), 1.0);
	float alpha = STROKE_COLOR.a * (1.0 - smoothstep(width - aa, width + aa, d));
	clip(alpha - 0.001);

	return float4(STROKE_COLOR.rgb, saturate(alpha));
}
