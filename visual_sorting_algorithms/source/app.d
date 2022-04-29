import glui;
import raylib;

import std.stdio;
import std.conv;
import std.random;

immutable int WIDTH = 512;
immutable int HEIGHT = 512;

void main()
{

    SetConfigFlags(ConfigFlags.FLAG_WINDOW_RESIZABLE);
    SetTraceLogLevel(TraceLogLevel.LOG_WARNING);
    InitWindow(512, 512, "Sorting Algorithms");
    SetTargetFPS(60);

    scope (exit)
        CloseWindow();

    GluiMapSpace root;

    root = mapSpace(
        
            .layout!(1, "fill"),
            makeTheme!q{
            GluiFrame.styleAdd.backgroundColor = color!"#aaa";
        },
    );

    int[] nums = generateList(256);
    auto rnd = MinstdRand0(uniform(0, int.max));
    nums = nums.randomShuffle(rnd);

    while (!WindowShouldClose)
    {
        bubbleSort(nums);
        nums.randomize();
        // quick_sort(nums);
        // nums.randomize();
    }

}

T[] randomize(T)(T[] list)
{
    auto rnd = MinstdRand0(uniform(0, int.max));
    list = list.randomShuffle(rnd);
    return list;
}

void graph(int[] arr, int ind)
{
    if (WindowShouldClose)
    {
        CloseWindow();
    }
    BeginDrawing();
    float x = 0;
    for (int k = 0; k < arr.length; k++)
    {   
        int i = arr[k];
        Color clr = Colors.WHITE;
        if (k == ind) {
            clr = Colors.RED;
        } 
        float rec_height = i * (HEIGHT / getMax(arr));
        DrawRectangleV(Vector2(x, 512 - rec_height), Vector2(WIDTH / arr.length - 1, rec_height), clr);
        x += WIDTH / arr.length;
    }
    ClearBackground(Colors.BLACK);
    EndDrawing();
}

int[] bubbleSort(int[] arr)
{
    int n = to!int(arr.length);
    for (int i = 0; i < n - 1; i++)
    {
        for (int j = 0; j < n - i - 1; j++)
        {
            if (arr[j] > arr[j + 1])
            {
                int temp = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = temp;
                graph(arr, arr[j]);
            }
        }
    }
    return arr;
}

int[] quick_sort(int[] arr)
{
    int[] lower = [];
    int[] equal = [];
    int[] higher = [];

    graph(arr, arr[0]);

    if (1 < arr.length)
    {
        int first = arr[0];
        foreach (i; arr)
        {
            if (i < first)
            {
                lower ~= i;
            }
            else if (i == first)
            {
                equal ~= i;
            }
            else if (i > first)
            {
                higher ~= i;
            }
        }
        writeln(lower ~ equal ~ higher);
        return quick_sort(lower) ~ equal ~ quick_sort(higher);
    }
    else
    {
        return arr;
    }
}

int[] generateList(int limit)
{
    int[] list;
    for (int i = 1; i < limit; i++)
    {
        list ~= i;
    }
    return list;
}

int getMax(int[] list)
{
    int max = 0;
    foreach (i; list)
    {
        if (i > max)
        {
            max = i;
        }
    }
    return max;
}
