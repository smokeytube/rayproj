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
	InitWindow(settings.WIDTH, settings.HEIGHT, "Visual Graphing Calculator");

    scope (exit) CloseWindow();



	while (!WindowShouldClose())
    {
        BeginDrawing();
        ClearBackground(Colors.BLACK);
        grid.grid();
        grid.graph("x^2");
        gui.draw();
        Functions.sigmaNotation(-3, 3, 100);
        EndDrawing();
	}
}