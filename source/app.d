import raylib;

import std.stdio;
import std.conv;

immutable int WIDTH = 512;
immutable int HEIGHT = 512;

int xi;
int yi;
int i1 = 1;
int i2 = 1;
float x;
float y;

int REC_WIDTH = 150;
int REC_HEIGHT = 50;

float slope = 0.5;

const char* text = "DVD";
int fnt = 40;

void main()
{
	InitWindow(WIDTH, HEIGHT, "Screensaver");
	SetTargetFPS(60);


	while (!WindowShouldClose())
	{
		BeginDrawing();
		ClearBackground(Colors.BLACK);

		update();

		EndDrawing();
	}
}

void update()
{
	xi += i1;
	yi += i2;

	x = xi;
	y = yi * slope;

	if (x >= WIDTH - REC_WIDTH)
	{
		i1 = -1;
	}
	else if (x <= 0)
	{
		i1 = 1;
	}
	if (y >= HEIGHT - REC_HEIGHT)
	{
		i2 = -1;
	}
	else if (y <= 0)
	{
		i2 = 1;
	}

	DrawRectangleV(Vector2(x, y), Vector2(REC_WIDTH, REC_HEIGHT), Colors.BLUE);
	//Draws text in the center of the rectange. It works well enough, although sometimes the text is ever so slightly off center.
	DrawText(text,
	to!int((x + REC_WIDTH / 2) - (to!string(text).length)*(fnt/2.825)), 
	to!int((y + REC_HEIGHT / 2) - (to!string(text).length) - (fnt/3)),
	 fnt, Colors.WHITE);
}
