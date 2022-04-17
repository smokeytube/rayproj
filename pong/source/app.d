import glui;
import raylib;

import std.array;
import std.range;
import std.format;
import std.stdio;
import std.conv;
import std.string;
import std.datetime;

import core.math;

//Data
immutable int WIDTH = 858;
immutable int HEIGHT = 525;

int static_block_size = HEIGHT / 30;
float xi = WIDTH / 2;
float yi = HEIGHT / 2;
int i1 = -1;
int i2 = 1;
float x;
float y;
bool point_scored = false;

int player_y = (HEIGHT / 2) - 50;
int player2_y = (HEIGHT / 2) - 50;

int paddle_width = 10;
int paddle_height = 100;
int projectile_width = 10;
int projectile_height = 10;
float projectile_slope = 1;
float projectile_speed = 2;
int paddle_speed = 2;

int player_score = 0;
int player2_score = 0;

double t = 0;

void main()
{
    //Create window
    InitWindow(WIDTH, HEIGHT, "Pong");
    SetTargetFPS(60);

    scope (exit)
        CloseWindow();

    // --------- User interface start ---------
    auto theme = makeTheme!q{
        GluiFrame.styleAdd!q{
            margin = 10;
            backgroundColor = color!"#FFFFFF";
        };
    };

    auto whiteTheme = makeTheme!q{
        GluiFrame.styleAdd.backgroundColor = color!"#ffffff";
        GluiButton!().styleAdd.backgroundColor = Colors.WHITE;
    };

    GluiSpace root, clearScreen, endScreen;

    clearScreen = vspace(
        
            .layout!(1, "fill"),
            theme,
            hspace(
                
                .layout!(1, "fill"),
            ),
    );

    endScreen = hframe(
        vframe(

            

            .layout!(1, "fill"),
            whiteTheme,
            hspace(

            

            .layout!(1, "fill"),
            label("Point Scored!"),
            ),
    ),
    );

    root = clearScreen;

    // --------- User interface end ---------

    //Loop which will draw the screensaver and UI while the window is not closed.
    while (!WindowShouldClose())
    {
        if (point_scored)
        {
            root = endScreen;
            if (t >= ((Clock.currTime() - SysTime.fromUnixTime(0)).total!"msecs" / 1000.0))
            {
            }
            else
            {
                root = clearScreen;
                point_scored = false;
                projectile_speed = 2;
                projectile_slope = 1;
                xi = WIDTH / 2;
                yi = HEIGHT / 2;
            }
        }
        BeginDrawing();
        processEvents();

        //This loop draws the different sides of the pong court. The loop starts at -1 opposed to 0 to have the first square not be drawn.
        for (int i = -1; i < 30; i += 2)
        {
            //I looked at an image of pong, and the height was 30 of these squares tall, hence why static_block_size appears often.
            DrawRectangleV(Vector2(WIDTH / 2 + (HEIGHT / 30) / 4, i * (static_block_size)), Vector2(
                    static_block_size, static_block_size), Colors
                    .LIGHTGRAY);
        }
        //Draw the top border and bottom border
        DrawRectangleV(Vector2(0, 0), Vector2(WIDTH, static_block_size), Colors.LIGHTGRAY);
        DrawRectangleV(Vector2(0, HEIGHT - static_block_size), Vector2(WIDTH, static_block_size), Colors
                .LIGHTGRAY);

        //Draw the paddles
        DrawRectangleV(Vector2(HEIGHT / 15, player_y), Vector2(paddle_width, paddle_height), Colors
                .WHITE);
        DrawRectangleV(Vector2(WIDTH - (HEIGHT / 15), player2_y), Vector2(paddle_width, paddle_height), Colors
                .WHITE);

        DrawText(toStringz(to!string(player_score)), WIDTH / 2 - 50, HEIGHT / 30, 50, Colors
                .WHITE);
        DrawText(toStringz(to!string(player2_score)), WIDTH / 2 + 50, HEIGHT / 30, 50, Colors
                .WHITE);
        if (!point_scored)
        {
            updateProjectile();
        }
        root.draw();
        ClearBackground(Colors.BLACK);
        EndDrawing();

    }
}

void processEvents()
{
    if (IsKeyDown(KeyboardKey.KEY_S) && player_y < HEIGHT - paddle_height - static_block_size)
    {
        player_y += paddle_speed;
    }
    else if (IsKeyDown(KeyboardKey.KEY_W) && player_y > static_block_size)
    {
        player_y -= paddle_speed;
    }
    if (IsKeyDown(KeyboardKey.KEY_DOWN) && player2_y < HEIGHT - paddle_height - static_block_size)
    {
        player2_y += paddle_speed;
    }
    else if (IsKeyDown(KeyboardKey.KEY_UP) && player2_y > static_block_size)
    {
        player2_y -= paddle_speed;
    }
}

void updateProjectile()
{
    xi += projectile_speed * i1;
    yi += projectile_speed * i2;

    x = xi;
    y = yi * projectile_slope;

    void onBounce()
    {
        //Create a new slope, 0.7 to 1, for a slight variation in projectile movement.
        float generated_slope = player_y / y;
        yi = setSlopeAndYCoord(generated_slope, projectile_slope, yi);
        projectile_slope = generated_slope;
        projectile_speed += 0.05;
    }

    void onScore()
    {
        t = ((Clock.currTime() - SysTime.fromUnixTime(0)).total!"msecs" / 1000.0) + 3;
        projectile_speed = 0;
        point_scored = true;
    }

    //If statements to make the rectangle bounce off the walls.
    if (x <= (HEIGHT / 15) + paddle_width && y >= player_y && y <= player_y + paddle_height)
    {
        onBounce();
        i1 = 1;
    }
    else if (x >= WIDTH - (HEIGHT / 15) - paddle_width && y >= player2_y && y <= player2_y + paddle_height)
    {
        onBounce();
        i1 = -1;
    }
    if (y >= HEIGHT - projectile_height - static_block_size || y <= static_block_size)
    {
        i2 *= -1;
    }
    if (x >= WIDTH - projectile_width)
    {
        player_score++;
        xi -= 2;
        onScore();
    }
    else if (x < 0)
    {
        player2_score++;
        xi += 2;
        onScore();
    }

    DrawRectangleV(Vector2(x, y), Vector2(projectile_width, projectile_height), Colors.WHITE);
}

/*This function is needed because otherwise, the rectange jumps unnaturally when the slope is set.
*/
float setSlopeAndYCoord(float newslope, float oldslope, float oldyi)
{
    float a = (oldyi) * (oldslope);
    float b = (oldyi) * newslope;
    //If the new slope is higher, the ratio will be below 1. If the new slope is lower, the ratio will be above 1.
    float ratio = a / b;
    //Multiply int yi by the ratio to get the appropriate position for the new slope, so the rectangle doesn't jump.
    return oldyi * ratio;
}