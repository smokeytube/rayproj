module components.functions;

import glui;
import raylib;

import components.settings;
import components.grid;

import std.array;
import std.range;
import std.format;
import std.stdio;
import std.conv;

public class Functions {
    //TODO make the equation somehow in settings
    public static void SigmaNotation(double a, double b, double n) {
        double i = a;
        while (i < b) {
            Grid.graphRectangle(i-(((b-a)/n)/2), (i*i*i-3*i)/2, (b-a)/n*settings.gridScalingX-5, (i*i*i-3*i)*settings.gridScalingY, Colors.BLUE);
            //Grid.graphRectangle(i-(((b-a)/n)/2), (i)/2, (b-a)/n*settings.gridScalingX-5, (i)*settings.gridScalingY, Colors.BLUE);
            i += (b-a)/n;
        }
        
    }
}