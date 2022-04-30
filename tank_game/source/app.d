import glui;
import raylib;

import std.stdio;
import std.conv;
import std.random;

// RUSSIAN PIG AND RUSSIAN SMART CAR

import sprites.tank;
import sprites.background;
import sprites.smartcar;

immutable int WIDTH = 800;
immutable int HEIGHT = 512;

float x = 0;
float y = 0;

float rot = 0;

int scale = 4;

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
    SmartCar smartCar = new SmartCar();

    tank.setScale(scale);
    background.setScale(scale);
    smartCar.setScale(scale);

    while (!WindowShouldClose())
    {
        BeginDrawing();
        processEvents();
        background.drawBackground(x, y, WIDTH, HEIGHT);
        tank.drawTank(tank.chassie_width/scale, HEIGHT-tank.chassie_height, rot);
        smartCar.drawCar(1000-x, HEIGHT-smartCar.car_height);

        ClearBackground(Colors.BLUE);

        EndDrawing();
    }

}


void processEvents()
{
    if (IsKeyDown(KeyboardKey.KEY_LEFT))
    {
        x -= scale;
    }
    else if (IsKeyDown(KeyboardKey.KEY_RIGHT))
    {
        x += scale;
    }

    if (IsKeyDown(KeyboardKey.KEY_UP) && rot > -45)
    {
        rot -= 1;
    }
    else if (IsKeyDown(KeyboardKey.KEY_DOWN) && rot < 10)
    {
        rot += 1;
    }
}