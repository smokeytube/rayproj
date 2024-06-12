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

        clearScreen = vspace(
            .layout!(1, "fill"),
            button("Settings", delegate{ writeln("hello"); })
        );

        root = clearScreen;
    }

    public void draw()
    {
        root.draw();
    }
}
