import glui;
import raylib;

import std.stdio;
import std.conv;
import std.random;

import sprites.tank;

immutable int WIDTH = 512;
immutable int HEIGHT = 512;

void main()
{

    InitWindow(512, 512, "Sorting Algorithms");
    SetTargetFPS(30);

    scope (exit)
        CloseWindow();

    GluiMapSpace root;

    root = mapSpace(
        
            .layout!(1, "fill"),
            makeTheme!q{
            GluiFrame.styleAdd.backgroundColor = color!"#aaa";
        },
    );

    Tank tank = new Tank();

    float x = 1;
    while (!WindowShouldClose)
    {
        x += 0.01;
        writeln(x);
        BeginDrawing();
        tank.drawTank(50, 50);
        tank.setScale(x);
        ClearBackground(Colors.BLACK);

        root.draw();

        EndDrawing();
    }

}