module components.gui;

import fluid;
import raylib;

import components.grid;
import components.settings;

import std.array;
import std.range;
import std.format;
import std.stdio;
import std.conv;

public class Gui
{
    private Space root, clearScreen, settings;

    this()
    {

        Theme theme = Theme.init.makeTheme!q{
            Space.styleAdd!q{
                margin = 5;
                margin.sideY = 10;
            };
            Frame.styleAdd!q{
                margin = 10;
                backgroundColor = color!"#fffa";
            };
            Button!().styleAdd!q{
                padding.sideTop = 100;
                textColor = color!"#ffffff";
                
            };
        };

        clearScreen = vspace(
            
                .layout!(1, "fill"),
                theme,
                vframe(
                    button("Settings", delegate{ writeln("hello"); }),
                    button("Close", { root = clearScreen; }),
                ),
        );

        root = clearScreen;
    }

    public void draw()
    {
        root.draw();
    }
}
