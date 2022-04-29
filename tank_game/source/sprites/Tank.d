module sprites.tank;

import glui;
import raylib;

import std.conv;

class Tank {
    Texture chassie;
    Rectangle chassie_rect;
    int chassie_width;
    int chassie_height;

    Texture turret;
    Rectangle turret_rect;
    int turret_width;
    int turret_height;
    int rot;

    float scale;

    this() {
        this.chassie = LoadTexture("./source/sprites/res/tank.png");
        this.turret = LoadTexture("./source/sprites/res/turret.png");
        setScale();
    }

    void drawTank(float x, float y) {
        DrawTextureRec(this.chassie, this.chassie_rect, Vector2(x, y), Colors.WHITE);
        DrawTextureRec(this.turret, this.turret_rect, Vector2(x+this.scale*32, y+this.scale*2), Colors.WHITE);
    }

    void setScale(float scale=1) {
        this.scale = scale;
        this.chassie_width = to!int(42 * this.scale);
        this.chassie_height = to!int(18 * this.scale);
        this.turret_width = to!int(20 * this.scale);
        this.turret_height = to!int(1 * this.scale);

        this.chassie.width = this.chassie_width;
        this.chassie.height = this.chassie_height;
        this.turret.width = this.turret_width;
        this.turret.height = this.turret_height;

        this.chassie_rect = Rectangle(0, 0, this.chassie_width, this.chassie_height);
        this.turret_rect = Rectangle(0, 0, this.turret_width, this.turret_height);
    }

    ~this() {
        UnloadTexture(this.chassie);
    }
}