import glui;
import raylib;

import std.stdio;
import std.conv;
import std.random;

immutable int WIDTH = 512;
immutable int HEIGHT = 512;

void main() {

    SetConfigFlags(ConfigFlags.FLAG_WINDOW_RESIZABLE);
    SetTraceLogLevel(TraceLogLevel.LOG_WARNING);
    InitWindow(512, 512, "Sorting Algorithms");
    SetTargetFPS(60);

    scope (exit) CloseWindow();

    GluiMapSpace root;
    GluiHoverButton!() draggableButton;

    root = mapSpace(
        .layout!(1, "fill"),
        makeTheme!q{
            GluiFrame.styleAdd.backgroundColor = color!"#aaa";
        },
    );

    int[] nums = generateList(128);
    auto rnd = MinstdRand0(uniform(0, int.max));
    nums = nums.randomShuffle(rnd);

    while (!WindowShouldClose) {
        bubbleSort(nums);
    }

}

void graph(int[] arr) {
    BeginDrawing();
    float x = 0;
    foreach(i; arr) {
        float rec_height = i*(HEIGHT/getMax(arr));
        DrawRectangleV(Vector2(x, 512-rec_height), Vector2(WIDTH/arr.length-1, rec_height), Colors.WHITE);
        x += WIDTH/arr.length;
    }
    ClearBackground(Colors.BLACK);
    EndDrawing();
}

void bubbleSort(int[] arr) {
    int n = to!int(arr.length);
    for (int i = 0; i < n-1; i++) {
        for (int j = 0; j < n-i-1; j++) {
            if (arr[j] > arr[j+1]) {
                int temp = arr[j];
                arr[j] = arr[j+1];
                arr[j+1] = temp;
                graph(arr);
            }
        }
    }
}

int[] generateList(int limit) {
    int[] list;
    for (int i = 1; i < limit; i++) {
        list ~= i;
    }
    return list;
}

int getMax(int[] list) {
    int max = 0;
    foreach(i; list) {
        if (i > max) {
            max = i;
        }
    }
    return max;
}