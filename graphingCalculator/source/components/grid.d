module components.grid;

import components.settings;
import components.functions;

import glui;
import raylib;

import std.array;
import std.range;
import std.format;
import std.stdio;
import std.conv;

public class Grid {


    void grid()
    {
        graphRectangle(0, -settings.offsetY/100, settings.WIDTH/100, settings.HEIGHT-settings.gridThickness*settings.HEIGHT, Colors.WHITE);
        graphRectangle(settings.offsetX/100, 0, settings.WIDTH-settings.gridThickness*settings.WIDTH, settings.HEIGHT/100, Colors.WHITE);
        
        for (int z = -1; z < 2; z+=2) {
            int markerPos = 0;
            while (markerPos < settings.WIDTH-settings.offsetX && markerPos > -settings.WIDTH-settings.offsetX) {
                graphRectangle(markerPos, 0, settings.WIDTH/100, 50, Colors.RED);
                markerPos += z;
            }
        }

        for (int z = -1; z < 2; z+=2) {
            int markerPos = 0;
            while (markerPos < settings.HEIGHT-settings.offsetY && markerPos > -settings.HEIGHT-settings.offsetY) {
                graphRectangle(0, markerPos, 50, settings.HEIGHT/100, Colors.RED);
                markerPos += z;
            }
        }
    }

    void graph(string str) {
        double inc = 0.1;
        for (double z = 10*(-settings.offsetX-500); z < 10*(settings.graphW-settings.offsetX); z += inc) {
            double nextY = Functions.evaluateEquation(z+inc);
            graphLine(z, Functions.evaluateEquation(z), z+inc, nextY, Colors.RED);
        }
    }

    public static void graphRectangle(double x, double y, double w, double h, Color c) {
        if (h < 0) {
            h = h*-1;
        }
        DrawRectangleV(Vector2((x*settings.gridScalingX+settings.WIDTH/2-settings.offsetX-w/2), (-y*settings.gridScalingY+settings.HEIGHT/2-settings.offsetY-h/2)), Vector2(w, h), c);
    }

    public static void graphLine(double sx, double sy, double ex, double ey, Color c) {
        DrawLineV(Vector2((sx*settings.gridScalingX+settings.WIDTH/2-settings.offsetX), (-sy*settings.gridScalingY+settings.HEIGHT/2-settings.offsetY)), Vector2((ex*settings.gridScalingX+settings.WIDTH/2-settings.offsetX), (-ey*settings.gridScalingY+settings.HEIGHT/2-settings.offsetY)), c);
    }
}