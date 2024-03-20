module app;

import glui;
import raylib;

import std.array;
import std.range;
import std.format;
import std.stdio;
import std.conv;
import std.math;

const int W = 500;
const int H = 500;

void main() {

    //Create window
	InitWindow(W, H, "Physics");
    SetTargetFPS(20);

    int x = 0;
    while (!WindowShouldClose()) {
        BeginDrawing();
        DrawRectangleV(Vector2(x+W/2, circle(x,10)+H/2), Vector2(10, 10), Colors.WHITE);
        ClearBackground(Colors.BLACK);
        EndDrawing();
        x++;
    }
}

float circle(float x, float r, float h=0, float k=0) {
    return sqrt(r-(x-h)^^2) + k;
}