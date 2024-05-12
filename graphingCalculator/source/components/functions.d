module components.functions;

import glui;
import raylib;
import evalex;

import components.settings;
import components.grid;

import std.array;
import std.range;
import std.format;
import std.stdio;
import std.conv;
import std.regex;

public class Functions {

    public static void sigmaNotation(double a, double b, double n) {
        double i = a;
        double y;
        while (i < b) {
            y = evaluateEquation(i);
            Grid.graphRectangle(i-(((b-a)/n)/2), (y)/2, (b-a)/n*settings.gridScalingX-5, (y)*settings.gridScalingY, Colors.BLUE);
            i += (b-a)/n;
        }
        
    }

    public static double evaluateEquation(double x) {
        string f = replaceAll(settings.equation, settings.reg, to!string(x));
        scope evaluator = new Eval!double(f);
        return evaluator.result;
    }
}