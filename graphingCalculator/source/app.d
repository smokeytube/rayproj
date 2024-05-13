import glui;
import raylib;

import components.settings;
import components.gui;
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
    Gui gui = new Gui();

    //Create window
	InitWindow(s.WIDTH, s.HEIGHT, "Visual Graphing Calculator");
    SetTargetFPS(10);

    scope (exit) CloseWindow();

    int n = 1;

	while (!WindowShouldClose())
    {
        BeginDrawing();
        ClearBackground(Colors.BLACK);
        Functions.rightSum(-5, 5, n, 1);
        grid.grid();
        grid.graph();
        gui.draw();
        n += 1;
        EndDrawing();
	}
}