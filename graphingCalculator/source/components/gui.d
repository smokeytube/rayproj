module components.gui;

import glui;
import raylib;

import components.grid;
import components.settings;

import std.array;
import std.range;
import std.format;
import std.stdio;
import std.conv;

public class Gui {
    private GluiSpace root, settings, clearScreen;
    private GluiTextInput _offsetX;


    this() {
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

        settings = vspace(
            .layout!(1, "fill"),
            theme,

            vframe(
                button("Close", delegate { 
                    root = clearScreen;
                    s.refresh = true;
                    writeln("here2");
                }),
            ),

            vscrollFrame(
                .layout!(1, "fill", "start"),
                rightTheme,
                vspace(
                    label("TEST"),
                    // _offsetX = textInput("Your input..."),
                    
                    vspace(
                        button("<", delegate {
                            // settings.gridIncPower -= 1; 
                        }),

                        button(">", delegate {
                            // settings.gridIncPower += 1; 
                        }),
                    ),


                    button("Save", delegate {
                        // settings.offsetX = to!int(_offsetX.value);
                    }),
                ),
            ),
        );

        clearScreen = vspace(
            .layout!(1, "fill"),
            theme,

            vframe(
                button("Settings", delegate { 
                    root = settings; 
                    s.refresh = true;
                    writeln("here");
                }),
            ),
            hspace(
                .layout!(1, "fill"),
            ),
        );
        root = clearScreen;
    }

    public void draw() {
        root.draw();
    }
}