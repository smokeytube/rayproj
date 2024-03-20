import glui;
import raylib;

import components.grid;

import std.array;
import std.range;
import std.format;
import std.stdio;
import std.conv;


void main() {

    Grid grid = new Grid();

    //Create window
	InitWindow(grid.WIDTH, grid.HEIGHT, "Visual Graphing Calculator");

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
                label("TEST"),
                // _offsetX = textInput("Your input..."),
                
                vspace(
                    button("<", delegate {
                        grid.gridIncPower -= 1; 
                    }),

                    button(">", delegate {
                        grid.gridIncPower += 1; 
                    }),
                ),


                button("Save", delegate {
                    grid.offsetX = to!int(_offsetX.value);
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

    root = clearScreen;

    // --------- User interface end ---------

	while (!WindowShouldClose())
    {
        BeginDrawing();
        ClearBackground(Colors.BLACK);
        grid.grid();
        grid.graph("x^2");
        root.draw();
        EndDrawing();
	}
}