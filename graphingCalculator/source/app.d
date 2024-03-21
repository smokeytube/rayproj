import glui;
import raylib;

import components.grid;
import components.settings;

import std.array;
import std.range;
import std.format;
import std.stdio;
import std.conv;

public immutable int WIDTH = 512*2;
public immutable int HEIGHT = 512*2;

public int guiW = WIDTH;
public int guiH = HEIGHT;

void main() {


    Grid grid = new Grid();

    //Create window
	InitWindow(settings.WIDTH, settings.HEIGHT, "Visual Graphing Calculator");

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

    // settings = vspace(
    //     .layout!(1, "fill"),
    //     theme,

    //     vframe(
    //         button("Close", { root = clearScreen; }),
    //     ),

    //     vscrollFrame(
    //         .layout!(1, "fill", "start"),
    //         rightTheme,
    //         vspace(
    //             label("TEST"),
    //             // _offsetX = textInput("Your input..."),
                
    //             vspace(
    //                 button("<", delegate {
    //                     settings.gridIncPower -= 1; 
    //                 }),

    //                 button(">", delegate {
    //                     settings.gridIncPower += 1; 
    //                 }),
    //             ),


    //             button("Save", delegate {
    //                 settings.offsetX = to!int(_offsetX.value);
    //             }),
    //         ),
    //     ),
    // );

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