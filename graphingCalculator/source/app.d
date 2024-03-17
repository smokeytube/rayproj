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
double gridThickness = 0.025;
int gridScaling = 10;
int offsetX = 0;
int offsetY = 0*-1;


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

    //Loop which will draw the screensaver and UI while the window is not closed
	while (!WindowShouldClose())
    {
        BeginDrawing();
        ClearBackground(Colors.BLACK);
        grid();
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
    DrawRectangleV(Vector2(WIDTH/2-offsetX, gridThickness*HEIGHT/2), Vector2(WIDTH/100, HEIGHT-gridThickness*HEIGHT), Colors.WHITE);
    DrawRectangleV(Vector2(gridThickness*WIDTH/2, HEIGHT/2-offsetY), Vector2(WIDTH-gridThickness*WIDTH, HEIGHT/100), Colors.WHITE);
}