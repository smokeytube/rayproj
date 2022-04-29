module sprites.background;

import glui;
import raylib;

import std.stdio;
import std.conv;

class Background {
    Texture background;
    Rectangle background_rect;
    int background_width;
    int background_height;

    float scale;

    this() {
        this.background = LoadTexture("./source/sprites/res/background.png");
        setScale();
    }

    void drawBackground(float x, float y, int screen_width, int screen_height) {
        this.background_rect = Rectangle(x, y, this.background_width, this.background_height);
        for (int i = 0; i < screen_width; i += background_width) {
            DrawTextureRec(this.background, this.background_rect, Vector2(i, screen_height-this.background_height), Colors.WHITE);
        }
    }

    void setScale(float scale=1) {
        this.scale = scale;
        this.background_width = to!int(64 * this.scale);
        this.background_height = to!int(64 * this.scale);

        this.background.width = this.background_width;
        this.background.height = this.background_height;
    }

    ~this() {
        UnloadTexture(this.background);
    }
}