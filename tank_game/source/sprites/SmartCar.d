module sprites.smartcar;

import glui;
import raylib;

import std.stdio;
import std.conv;

class SmartCar {
    Texture car;
    Rectangle car_rect;
    int car_width;
    int car_height;

    float scale;

    this(bool mirrored=false) {
        this.car = LoadTexture("./source/sprites/res/smartcar.png");
        setScale();
    }

    void draw(float x, float y) {
        DrawTextureRec(this.car, this.car_rect, Vector2(x, y), Colors.WHITE);
    }

    void setScale(float scale=1) {
        this.scale = scale;
        this.car_width = to!int(30 * this.scale);
        this.car_height = to!int(20 * this.scale);

        this.car.width = this.car_width;
        this.car.height = this.car_height;

        this.car_rect = Rectangle(0, 0, this.car_width, this.car_height);
    }

    ~this() {
        UnloadTexture(this.car);
    }
}
