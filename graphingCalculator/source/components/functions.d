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
        sumBase(a, b, n, 0, buffer);
    }

    public static void leftSum(double a, double b, int n, double buffer = 0) {
        sumBase(a, b, n, 1, buffer);
    }

    public static void middleSum(double a, double b, int n, double buffer = 0) {
        sumBase(a, b, n, 0.5, buffer);
    }

    public static void sumBase(double a, double b, int n, double rlm, double buffer) {
        double inc = (b-a)/n;
        double i = a+inc;
        double y;
        int count = 0;
        while (i < to!int(b)) {
            y = evaluateEquation(i-inc*rlm);
            Grid.graphRectangle(i-((inc)/2)+buffer/s.gridScalingX, (y)/2, inc*s.gridScalingX-buffer, (y)*s.gridScalingY, Colors.BLUE);
            i += inc;
            count++;
        }
        if (count < n) {
            y = evaluateEquation(i-inc*rlm);
            Grid.graphRectangle(i-((inc)/2)+buffer/s.gridScalingX, (y)/2, inc*s.gridScalingX-buffer, (y)*s.gridScalingY, Colors.BLUE);
        }
    }

    public static void trapezoidalSum(double a, double b, int n, double rlm, double buffer) {
        double inc = (b-a)/n;
        double i = a+inc;
        double y;
        int count = 0;
        while (i < to!int(b)) {
            y = evaluateEquation(i-inc*rlm);
            Grid.graphRectangle(i-((inc)/2)+buffer/s.gridScalingX, (y)/2, inc*s.gridScalingX-buffer, (y)*s.gridScalingY, Colors.BLUE);
            i += inc;
            count++;
        }
        if (count < n) {
            y = evaluateEquation(i-inc*rlm);
            Grid.graphRectangle(i-((inc)/2)+buffer/s.gridScalingX, (y)/2, inc*s.gridScalingX-buffer, (y)*s.gridScalingY, Colors.BLUE);
        }
    }

    public static double evaluateEquation(double x) {
        return Evaluator(s.equation, x).eval;
    }
}