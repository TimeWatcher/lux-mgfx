// Example shader that displays a colored square in the middle of the screen

#include "common.hlsl"

bool ContainsSquare(float2 screen_point, float2 square_center, float square_size)
{
	float half_size = square_size * 0.5;
    return screen_point.x >= (square_center.x - half_size)
		&& screen_point.x <= (square_center.x + half_size)
		&& screen_point.y >= (square_center.y - half_size)
		&& screen_point.y <= (square_center.y + half_size);
}

float4 main( PS_INPUT i ) : COLOR
{
	// background color with full transparency
	float4 color = float4(0.0, 0.0, 0.0, 0.0);

	// map from normalized to screen cordinates [0, 1] -> [0, size]
	float2 uv = i.uv;
	float2 screen_point = uv / TexBaseSize;

	// center of screen in screen coordinates
	float square_size = 200.0;
	float2 square_center = (1.0 / TexBaseSize) * 0.5;

	// check if pixel is inside the square
    if (ContainsSquare(screen_point, square_center, square_size))
    {
        color = float4(1.0, 0.0, 0.0, 1.0);
    }

	return color;
}
