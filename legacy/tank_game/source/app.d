import glui;
import raylib;

import std.stdio;
import std.conv;
import std.random;

import core.math;

import sprites.tank;
import sprites.background;
import sprites.smartcar;
import sprites.bullet;

immutable int WIDTH = 800;
immutable int HEIGHT = 512;

immutable float g = 9.8;
immutable float v = 1219;

float x = 0;
float y = 0;
float t = 0;

float vx = 0;
float vy = 0;

float bullet_x = 0;
float bullet_y = 0;
bool shoot = false;

float rot = 0;

int scale = 4;

void main()
{

    InitWindow(WIDTH, HEIGHT, "Слава Украине Симулятор");
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
    Background background = new Background();
    SmartCar smartCar = new SmartCar();
    Bullet bullet = new Bullet();

    tank.setScale(scale);
    background.setScale(scale);
    smartCar.setScale(scale);
    bullet.setScale(scale);

    while (!WindowShouldClose())
    {
        BeginDrawing();
        processEvents();
        background.draw(x, y, WIDTH, HEIGHT);
        tank.draw(tank.chassie_width/scale, HEIGHT-tank.chassie_height, rot);
        smartCar.draw(1000-x, HEIGHT-smartCar.car_height);

        if (shoot) {
            updateBullet();
            bullet.draw(bullet_x, bullet_y);
        }

        ClearBackground(Colors.BLUE);

        EndDrawing();
    }

}

void updateBullet() {
    bullet_x = bullet_x + vx * t;
    bullet_y = bullet_y - vy * t;
    vy = vy - 0.5 * 2 * t;
    t += 0.1;

    if (bullet_y > HEIGHT) {
        shoot = false;
        t = 0;
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

    if (IsKeyDown(KeyboardKey.KEY_UP) && rot < 45)
    {
        rot += 1;
        writeln(rot);
    }
    else if (IsKeyDown(KeyboardKey.KEY_DOWN) && rot > -10)
    {
        rot -= 1;
        writeln(rot);
    }

    if (IsKeyPressed(KeyboardKey.KEY_SPACE))
    {
        shoot = true;
        bullet_x = 200;
        bullet_y = 100;
        vx = v * cos(rot);
        vy = v * sin(rot);
    }
}