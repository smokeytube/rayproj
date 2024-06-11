import raylib;

import components.settings;
// import components.gui;
import components.grid;
import components.functions;

import std.array;
import std.range;
import std.format;
import std.stdio;
import std.conv;

public immutable int WIDTH = 512*2;
public immutable int HEIGHT = 512*2;

public int guiW = WIDTH;
public int guiH = HEIGHT;

void main() {


    Grid grid = new Grid();

    //Create window
	InitWindow(s.WIDTH, s.HEIGHT, "Visual Graphing Calculator");
    SetTargetFPS(30);

    scope (exit) CloseWindow();

    int z = 1;

	while (!WindowShouldClose())
    {
        BeginDrawing();
        ClearBackground(Colors.BLACK);
        Functions.middleSum(-5, 5, z, 1);
        grid.grid();
        grid.graph();
        // gui.draw();
        EndDrawing();
        z++;
	}
}