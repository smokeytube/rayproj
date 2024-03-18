import glui;
import raylib;

import std.array;
import std.range;
import std.format;
import std.stdio;
import std.conv;

//All data immutable by the user
immutable int WIDTH = 512*2;
immutable int HEIGHT = 512*2;

//All data mutable by the user
int graphW = WIDTH;
int graphH = HEIGHT;
int guiW = WIDTH;
int guiH = HEIGHT;
double gridThickness = 0.025;
int gridScalingX = 100;
int gridScalingY = 100;
int offsetX = 100;
int offsetY = 100;


void main() {

    //Create window
	InitWindow(WIDTH, HEIGHT, "Visual Graphing Calculator");

    scope (exit) CloseWindow();

    // --------- User interface start ---------
    auto theme = makeTheme!q{
        GluiFrame.styleAdd!q{

            margin = 10;
            backgroundColor = color!"#fffa";
        };
    };

    immutable rightTheme = makeTheme!q{
        GluiSpace.styleAdd!q{
            margin = 5;
            margin.sideY = 10;
        };
        GluiButton!().styleAdd!q{
            margin.sideTop = 10;
        };
    };

    GluiScrollBar slopeBar, widthBar, heightBar, speedBar;
    GluiSpace root, settings, clearScreen;

    GluiTextInput _offsetX;

    settings = vspace(
        .layout!(1, "fill"),
        theme,

        vframe(
            button("Close", { root = clearScreen; }),
        ),
        vscrollFrame(
            .layout!(1, "fill", "start"),
            rightTheme,
            vspace(
                label("Change slope"),
                slopeBar = hscrollBar(.layout!"fill"),

                button("Save", delegate {
                    //Hello
                }),
            ),
        ),
        vscrollFrame(
            .layout!(1, "fill", "start"),
            rightTheme,
            vspace(
                label("Change width and height"),
                widthBar = hscrollBar(.layout!"fill"),
                heightBar = hscrollBar(.layout!"fill"),

                button("Save", delegate {
                    writeln("Hello");
                }),
            ),
        ),
        vscrollFrame(
            .layout!(1, "fill", "start"),
            rightTheme,
            vspace(
                label("Change the movement speed"),
                speedBar = hscrollBar(.layout!"fill"),

                button("Save", delegate {
                    //Hello
                }),
            ),
        ),
        vscrollFrame(
            .layout!(1, "fill", "start"),
            rightTheme,
            vspace(
                label("TEST"),
                _offsetX = textInput("Your input..."),
                

                button("Save", delegate {
                    offsetX = to!int(_offsetX.value);
                }),
            ),
        ),
    );

    clearScreen = vspace(
        .layout!(1, "fill"),
        theme,

        vframe(
            button("Settings", { root = settings; }),
        ),
        hspace(
            .layout!(1, "fill"),
        ),
    );

    // slopeBar.availableSpace = 5_000;
    // widthBar.availableSpace = WIDTH*10;
    // heightBar.availableSpace = HEIGHT*10;
    // speedBar.availableSpace = 960;

    // slopeBar.position = to!int(slope*1000);
    // widthBar.position = rec_width*10;
    // heightBar.position = rec_height*10;
    // speedBar.position = mov_speed;

    root = clearScreen;

    // --------- User interface end ---------

	while (!WindowShouldClose())
    {
        BeginDrawing();
        ClearBackground(Colors.BLACK);
        grid();
        // graph("x^2");
        update();
        root.draw();
        EndDrawing();
	}
}

void update()
{

}

void grid()
{

    graphRectangle(0, 0-offsetX/100, WIDTH/100, HEIGHT-gridThickness*HEIGHT, Colors.WHITE);
    graphRectangle(0+offsetY/100, 0, WIDTH-gridThickness*WIDTH, HEIGHT/100, Colors.WHITE);
    
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
        graphRectangle(z, z*z - z, 4, 4, Colors.BLUE);
        double nextY = (z+inc)*(z+inc) - (z+inc);
        graphLine(z, z*z - z, z+inc, nextY, Colors.RED);
    }
    graphRectangle(2, 2, 40, 40, Colors.BLUE);
}


void graphRectangle(double x, double y, double w, double h, Color c) {
    DrawRectangleV(Vector2((x*gridScalingX+WIDTH/2-offsetX-w/2), (-y*gridScalingY+HEIGHT/2-offsetY-h/2)), Vector2(w, h), c);
}

void graphLine(double sx, double sy, double ex, double ey, Color c) {
    DrawLineV(Vector2((sx*gridScalingX+WIDTH/2-offsetX), (-sy*gridScalingY+HEIGHT/2-offsetY)), Vector2((ex*gridScalingX+WIDTH/2-offsetX), (-ey*gridScalingY+HEIGHT/2-offsetY)), c);
}