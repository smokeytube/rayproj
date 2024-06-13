import glui;
import raylib;

import std.array;
import std.range;
import std.format;
import std.stdio;
import std.conv;

//All data immutable by the user
immutable int WIDTH = 512;
immutable int HEIGHT = 512;
float xi = 0;
float yi = 0;
int i1 = 1;
int i2 = 1;
int i3 = 1;
int fnt = 40;
float x;
float y;
const char* text = "DVD";
bool set_fps = true;
bool set_slope = true;

//All data mutable by the user
int rec_width = 150;
int rec_height = 50;
float slope = 0.5;
int mov_speed = 60; //in FPS

void main() {

    //Create window
	InitWindow(WIDTH, HEIGHT, "Screensaver");

    scope (exit) CloseWindow();

    // --------- User interface start ---------
    auto theme = makeTheme!q{
        GluiFrame.styleAdd!q{

            margin = 10;
            backgroundColor = color!"#fffa";
        };
    };

    immutable rightTheme = makeTheme!q{
        GluiSpace.styleAdd!q{
            margin = 5;
            margin.sideY = 10;
        };
        GluiButton!().styleAdd!q{
            padding.sideTop = 100;
        };
    };

    GluiScrollBar slopeBar, widthBar, heightBar, speedBar;
    GluiSpace root, settings, clearScreen;

    settings = vspace(
        .layout!(1, "fill"),
        theme,

        vframe(
            button("Close", { root = clearScreen; }),
        ),
        vscrollFrame(
            .layout!(1, "fill", "start"),
            rightTheme,
            vspace(
                label("Change slope"),
                slopeBar = hscrollBar(.layout!"fill"),

                button("Save", delegate {
                    set_slope = true;
                }),
            ),
        ),
        vscrollFrame(
            .layout!(1, "fill", "start"),
            rightTheme,
            vspace(
                label("Change width and height"),
                widthBar = hscrollBar(.layout!"fill"),
                heightBar = hscrollBar(.layout!"fill"),

                button("Save", {
                    rec_width = to!int(widthBar.position/10);
                    rec_height = to!int(heightBar.position/10);
                    /*Since font fnt corresponds nicely to the height, a little extra calculation
                    * is needed for thw width to make the text fit in the rectangle*/
                    if (rec_height+rec_height/1.5 >= rec_width) {
                        fnt = to!int(rec_width*0.8*0.5);
                    } else {
                        fnt = to!int(rec_height*0.8);
                    }
                }),
            ),
        ),
        vscrollFrame(
            .layout!(1, "fill", "start"),
            rightTheme,
            vspace(
                label("Change the movement speed"),
                speedBar = hscrollBar(.layout!"fill"),

                button("Save", delegate {
                    //+30 has to be added as to keep a minimum of 30 fps. Otherwise the UI will lag or outright freeze.
                    mov_speed = to!int(speedBar.position)+30;
                    set_fps = true;
                }),
            ),
        ),
    );

    clearScreen = vspace(
        .layout!(1, "fill"),
        theme,

        vframe(
            button("Settings", { root = settings; }),
        ),
        hspace(
            .layout!(1, "fill"),
        ),
    );

    slopeBar.availableSpace = 5_000;
    widthBar.availableSpace = WIDTH*10;
    heightBar.availableSpace = HEIGHT*10;
    speedBar.availableSpace = 960;

    slopeBar.position = to!int(slope*1000);
    widthBar.position = rec_width*10;
    heightBar.position = rec_height*10;
    speedBar.position = mov_speed;

    root = clearScreen;

    // --------- User interface end ---------

    //Loop which will draw the screensaver and UI while the window is not closed
	while (!WindowShouldClose())
    {
        if (set_fps) {
            SetTargetFPS(mov_speed);
            set_fps = false;
        }
        if (set_slope) {
            //0.001 has to be added because the program will misbehave if the value is 0
            setSlopeAndYCoord(to!float(slopeBar.position)/1000+0.001, &slope, &yi);
            set_slope = false;
        }
        BeginDrawing();
        ClearBackground(Colors.BLACK);
        update();
        root.draw();
        EndDrawing();
	}
}

void update()
{
	xi += i1;
	yi += i2;

	x = xi;
	y = yi * slope;

    //If statements to make the rectangle bounce off the walls.
	if (x >= WIDTH - rec_width)
	{
		i1 = -1;
	}
	else if (x <= 0)
	{
		i1 = 1;
	}
	if (y >= HEIGHT - rec_height)
	{
		i2 = -1;
	}
	else if (y <= 0)
	{
		i2 = 1;
	}

	DrawRectangleV(Vector2(x, y), Vector2(rec_width, rec_height), Colors.BLUE);

	/*Draws text in the center of the rectange. It works well enough, although sometimes the text is ever so slightly off center.
	* That is not my fault. There is no function for drawing a text with vecotors, only an integer X and Y.*/
	DrawText(text,
	to!int((x + rec_width / 2) - (to!string(text).length)*(fnt/2.825)), 
	to!int((y + rec_height / 2) - (to!string(text).length) - (fnt/3)),
	 fnt, Colors.WHITE);
}

/*This function is needed because otherwise, the rectange jumps unnaturally when the slope is set.
* A pointer to the variable slope and yi, defined at the beggining of the program, is passed to this function,
* so this function can be easily pasted into other programs.
*/
void setSlopeAndYCoord(float newslope, float *oldslope, float *oldyi) {
    float a = (*oldyi) * (*oldslope);
    float b = (*oldyi) * newslope;
    //If the new slope is higher, the ratio will be below 1. If the new slope is lower, the ratio will be above 1.
    float ratio = a/b;
    // Try-catch block is needed because if the ratio is 0, like when the program starts up, the program will crash.
    try {
        //Multiply int yi by the ratio to get the appropriate position for the new slope, so the rectangle doesn't jump.
        *oldyi = to!int((*oldyi) * ratio);
    } catch (std.conv.ConvException e) {
        *oldyi = 0;
    }
    *oldslope = newslope;
}