module components.settings;

import std.regex;

public Settings settings;

public struct Settings {
    //All data immutable by the user
    immutable int WIDTH = 512*2;
    immutable int HEIGHT = 512*2;

    //All data mutable by the user
    int graphW = WIDTH;
    int graphH = HEIGHT;

    double gridThickness = 0.025;
    int gridScalingX = 100;
    int gridScalingY = 100;
    int offsetX = 200;
    int offsetY = 0;
    int gridIncPower = 0;
    int gridInc = 0;

    string equation = "x*x*x-3*x";

    auto reg = regex("x");
}