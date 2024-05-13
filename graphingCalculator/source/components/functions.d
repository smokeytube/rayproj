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

    public static void rightSum(double a, double b, int n, double buffer = 0) {
        double inc = (b-a)/n;
        double i = a+inc;
        double y;
        while (i < b+inc) {
            y = evaluateEquation(i);
            Grid.graphRectangle(i-((inc)/2)+buffer/s.gridScalingX, (y)/2, inc*s.gridScalingX-buffer, (y)*s.gridScalingY, Colors.BLUE);
            i += inc;
        }
    }

    public static double evaluateEquation(double x) {
        return Evaluator(s.equation, x).eval;
    }
}