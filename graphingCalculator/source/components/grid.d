module components.grid;

import glui;
import raylib;

import std.array;
import std.range;
import std.format;
import std.stdio;
import std.conv;

public class Grid {
    //All data immutable by the user
    public immutable int WIDTH = 512*2;
    public immutable int HEIGHT = 512*2;

    //All data mutable by the user
    public int graphW = WIDTH;
    public int graphH = HEIGHT;
    public int guiW = WIDTH;
    public int guiH = HEIGHT;
    public double gridThickness = 0.025;
    public int gridScalingX = 100;
    public int gridScalingY = 100;
    public int offsetX = 0;
    public int offsetY = 0;
    public int gridIncPower = 0;
    public int gridInc = 0;

    void grid()
    {
        graphRectangle(0, -offsetY/100, WIDTH/100, HEIGHT-gridThickness*HEIGHT, Colors.WHITE);
        graphRectangle(offsetX/100, 0, WIDTH-gridThickness*WIDTH, HEIGHT/100, Colors.WHITE);
        
        for (int z = -1; z < 2; z+=2) {
            int markerPos = 0;
            while (markerPos < WIDTH-offsetX && markerPos > -WIDTH-offsetX) {
                graphRectangle(markerPos, 0, WIDTH/100, 50, Colors.RED);
                markerPos += z;
            }
        }

        for (int z = -1; z < 2; z+=2) {
            int markerPos = 0;
            while (markerPos < HEIGHT-offsetY && markerPos > -HEIGHT-offsetY) {
                graphRectangle(0, markerPos, 50, HEIGHT/100, Colors.RED);
                markerPos += z;
            }
        }
    }

    void graph(string str) {
        double inc = 0.1;
        for (double z = 10*(-offsetX-500); z < 10*(graphW-offsetX); z += inc) {
            // graphRectangle(z, z*z - z, 4, 4, Colors.BLUE);
            double nextY = (z+inc)*(z+inc) - (z+inc);
            graphLine(z, z*z - z, z+inc, nextY, Colors.RED);
        }
    }

    void graphRectangle(double x, double y, double w, double h, Color c) {
        DrawRectangleV(Vector2((x*gridScalingX+WIDTH/2-offsetX-w/2), (-y*gridScalingY+HEIGHT/2-offsetY-h/2)), Vector2(w, h), c);
    }

    void graphLine(double sx, double sy, double ex, double ey, Color c) {
        DrawLineV(Vector2((sx*gridScalingX+WIDTH/2-offsetX), (-sy*gridScalingY+HEIGHT/2-offsetY)), Vector2((ex*gridScalingX+WIDTH/2-offsetX), (-ey*gridScalingY+HEIGHT/2-offsetY)), c);
    }
}