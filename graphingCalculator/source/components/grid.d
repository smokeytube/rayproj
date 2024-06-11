module components.grid;

import components.settings;
import components.functions;

import raylib;

import std.array;
import std.range;
import std.format;
import std.stdio;
import std.conv;

public class Grid {


    void grid()
    {
        graphRectangle(0, -s.offsetY/100, 2, s.HEIGHT-s.gridThickness*s.HEIGHT, Colors.WHITE);
        graphRectangle(s.offsetX/100, 0, s.WIDTH-s.gridThickness*s.WIDTH, 2, Colors.WHITE);
        
        for (int z = -1; z < 2; z+=2) {
            int markerPos = 0;
            while (markerPos < s.WIDTH-s.offsetX && markerPos > -s.WIDTH-s.offsetX) {
                graphRectangle(markerPos, 0, 2, 50, Colors.RED);
                markerPos += z;
            }
        }

        for (int z = -1; z < 2; z+=2) {
            int markerPos = 0;
            while (markerPos < s.HEIGHT-s.offsetY && markerPos > -s.HEIGHT-s.offsetY) {
                graphRectangle(0, markerPos, 50, 2, Colors.RED);
                markerPos += z;
            }
        }
    }

    void graph() {
        double inc = 0.1;
        for (double z = 10*(-s.offsetX-500); z < 10*(s.graphW-s.offsetX); z += inc) {
            double nextY = Functions.evaluateEquation(z+inc);
            graphLine(z, Functions.evaluateEquation(z), z+inc, nextY, Colors.RED);
        }
    }

    public static void graphRectangle(double x, double y, double w, double h, Color c) {
        if (h < 0) {
            h = h*-1;
        }
        DrawRectangleV(Vector2((x*s.gridScalingX+s.WIDTH/2-s.offsetX-w/2), (-y*s.gridScalingY+s.HEIGHT/2-s.offsetY-h/2)), Vector2(w, h), c);
    }

    public static void graphLine(double sx, double sy, double ex, double ey, Color c) {
        DrawLineV(Vector2((sx*s.gridScalingX+s.WIDTH/2-s.offsetX), (-sy*s.gridScalingY+s.HEIGHT/2-s.offsetY)), Vector2((ex*s.gridScalingX+s.WIDTH/2-s.offsetX), (-ey*s.gridScalingY+s.HEIGHT/2-s.offsetY)), c);
    }
}