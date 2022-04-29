import glui;
import raylib;

import std.stdio;
import std.conv;
import std.random;

import sprites.tank;
import sprites.background;

immutable int WIDTH = 512;
immutable int HEIGHT = 512;

float x = 0;
float y = 0;

void main()
{

    InitWindow(WIDTH, HEIGHT, "Sorting Algorithms");
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

    Tank tank = new Tank(false);
    Background background = new Background();

    int scale = 4;

    tank.setScale(scale);
    background.setScale(scale);

    float j = 0;
    while (!WindowShouldClose())
    {
        setFullScreen();
        BeginDrawing();
        processEvents();
        background.drawBackground(x, y, WIDTH, HEIGHT);
        tank.drawTank(tank.chassie_width/scale, HEIGHT-tank.chassie_height, j);

        ClearBackground(Colors.BLUE);

        EndDrawing();
    }

}


void setFullScreen() {
    if (IsKeyPressed(KeyboardKey.KEY_ENTER) && (IsKeyDown(KeyboardKey.KEY_LEFT_ALT) || IsKeyDown(KeyboardKey.KEY_RIGHT_ALT)))
    {
        int display = GetCurrentMonitor();

        
        if (IsWindowFullscreen())
        {
            SetWindowSize(WIDTH, HEIGHT);
        }
        else
        {
            SetWindowSize(GetMonitorWidth(display), GetMonitorHeight(display));
        }

        ToggleFullscreen();
    }
}


void processEvents()
{
    if (IsKeyDown(KeyboardKey.KEY_LEFT))
    {
        x -= 1;
    }
    else if (IsKeyDown(KeyboardKey.KEY_RIGHT))
    {
        x += 1;
    }
}