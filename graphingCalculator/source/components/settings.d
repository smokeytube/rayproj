module components.settings;

import std.regex;

public Settings s;

public struct Settings {
    //All data immutable by the user
    immutable int WIDTH = 512*2;
    immutable int HEIGHT = 512*2;

    //All data mutable by the user
    int graphW = WIDTH;
    int graphH = HEIGHT;

    double gridThickness = 0.025;
    int gridScalingX = 50;
    int gridScalingY = 50;
    int offsetX = 0;
    int offsetY = 0;
    int gridIncPower = 0;
    int gridInc = 0;

    string equation = "x";

    //All data mutable by the program
    bool refresh = true;
}