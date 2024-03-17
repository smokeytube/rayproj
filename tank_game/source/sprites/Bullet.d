module sprites.bullet;

import glui;
import raylib;

import std.stdio;
import std.conv;

class Bullet {
    Texture bullet;
    Rectangle bullet_rect;
    int bullet_width;
    int bullet_height;

    float scale;

    this() {
        this.bullet = LoadTexture("./source/sprites/res/bullet.png");
        setScale();
    }

    void draw(float x, float y) {
        DrawTextureRec(this.bullet, this.bullet_rect, Vector2(x, y), Colors.WHITE);
    }

    void setScale(float scale=1) {
        this.scale = scale;
        this.bullet_width = to!int(2 * this.scale);
        this.bullet_height = to!int(1 * this.scale);

        this.bullet.width = this.bullet_width;
        this.bullet.height = this.bullet_height;

        this.bullet_rect = Rectangle(0, 0, this.bullet_width, this.bullet_height);
    }

    ~this() {
        UnloadTexture(this.bullet);
    }
}
