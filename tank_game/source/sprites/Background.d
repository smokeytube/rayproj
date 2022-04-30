module sprites.background;

import glui;
import raylib;

import std.stdio;
import std.conv;

class Background {
    Texture background1;
    Texture background2;
    Texture background3;
    Rectangle background_rect1;
    Rectangle background_rect2;
    Rectangle background_rect3;
    int background_width;
    int background_height;

    float scale;

    this() {
        this.background1 = LoadTexture("./source/sprites/res/background1.png");
        this.background2 = LoadTexture("./source/sprites/res/background2.png");
        this.background3 = LoadTexture("./source/sprites/res/background3.png");
        setScale();
    }

    void drawBackground(float x, float y, int screen_width, int screen_height) {
        this.background_rect1 = Rectangle(x, y, this.background_width, this.background_height);
        this.background_rect2 = Rectangle(x/1.25, y, this.background_width, this.background_height);
        this.background_rect3 = Rectangle(x/2, y, this.background_width, this.background_height);
        for (int i = 0; i < screen_width; i += background_width) {
            DrawTextureRec(this.background3, this.background_rect3, Vector2(i, screen_height-this.background_height), Colors.WHITE);
        }
        for (int i = 0; i < screen_width; i += background_width) {
            DrawTextureRec(this.background2, this.background_rect2, Vector2(i, screen_height-this.background_height), Colors.WHITE);
        }
        for (int i = 0; i < screen_width; i += background_width) {
            DrawTextureRec(this.background1, this.background_rect1, Vector2(i, screen_height-this.background_height), Colors.WHITE);
        }
    }

    void setScale(float scale=1) {
        this.scale = scale;
        this.background_width = to!int(64 * this.scale);
        this.background_height = to!int(64 * this.scale);

        this.background1.width = this.background_width;
        this.background1.height = this.background_height;
        this.background2.width = this.background_width;
        this.background2.height = this.background_height;
        this.background3.width = this.background_width;
        this.background3.height = this.background_height;
    }

    ~this() {
        UnloadTexture(this.background1);
        UnloadTexture(this.background2);
    }
}