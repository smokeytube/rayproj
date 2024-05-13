module components.functions;

import glui;
import raylib;

import components.settings;
import components.grid;
import components.evaluator;

import std.array;
import std.range;
import std.format;
import std.stdio;
import std.conv;
import std.regex;

public class Functions {

    public static void rightSum(double a, double b, double n, double buffer = 0) {
        double i = a;
        double y;
        while (i < b) {
            y = evaluateEquation(i);
            Grid.graphRectangle(i-(((b-a)/n)/2)+buffer/s.gridScalingX, (y)/2, (b-a)/n*s.gridScalingX-buffer, (y)*s.gridScalingY, Colors.BLUE);
            i += (b-a)/n;
        }
    }

    public static double evaluateEquation(double x) {
        return Evaluator(s.equation, x).eval;
    }
}