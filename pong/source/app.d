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

immutable int static_block_size = HEIGHT / 30;

Paddle p = Paddle();

int player_score = 0;
int player2_score = 0;

double t = 0;

struct Projectile
{
    int projectile_width = 10;
    int projectile_height = 10;
    float projectile_slope = 1;
    float projectile_speed = 2;
    bool point_scored = false;
    float xi = WIDTH / 2;
    float yi = HEIGHT / 2;
    int i1 = -1;
    int i2 = 1;
    float x;
    float y;

    private void onBounce()
    {
        float difference_paddle_y;
        if (p.paddle1_y > p.paddle2_y) {
            difference_paddle_y = p.paddle1_y - p.paddle2_y;
        }
        else if (p.paddle1_y < p.paddle2_y) {
            difference_paddle_y = p.paddle2_y - p.paddle1_y;
        }
        else {
            difference_paddle_y = 1;
        }
        /*Create a new slope, based on the averages of the two pong paddles, to add a little more skill to the game.
        * The person who is about to hit the ball should aim to have as different of a Y as possible, so that the ball bounces faster
        * and with a higher slope. The person who is not currently about to hit the ball should aim to make the y as close as possible
        * with the opponents, so that the ball bounces slower and with a lower slope.
        *
        * Min slope = 1/    (HEIGHT/5)
        * Max slope = 5
        */
        float generated_slope = difference_paddle_y/(HEIGHT/5);
        yi = setSlopeAndYCoord(generated_slope, projectile_slope, yi);
        projectile_slope = generated_slope;
        projectile_speed += 0.05;
    }

    private void onScore()
    {
        t = ((Clock.currTime() - SysTime.fromUnixTime(0)).total!"msecs" / 1000.0) + 3;
        projectile_speed = 0;
        point_scored = true;
    }

    public void updateProjectile()
    {
        // NOTE FOR LATER: CALCULATE X AND Y IN MAIN THEN PASS THE VALUES HERE
        xi += projectile_speed * i1;
        yi += projectile_speed * i2;

        x = xi;
        y = yi * projectile_slope;

        //If statements to make the rectangle bounce off the walls.
        if (x <= (HEIGHT / 15) + p.paddle_width && y >= p.paddle1_y && y <= p.paddle1_y + p
            .paddle_height)
        {
            onBounce();
            i1 = 1;
        }
        else if (x >= WIDTH - (HEIGHT / 15) - p.paddle_width && y >= p.paddle2_y && y <= p.paddle2_y + p
            .paddle_height)
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
    private float setSlopeAndYCoord(float newslope, float oldslope, float oldyi)
    {
        float a = oldyi * oldslope;
        float b = oldyi * newslope;
        //If the new slope is higher, the ratio will be below 1. If the new slope is lower, the ratio will be above 1.
        float ratio = a / b;
        //Multiply int yi by the ratio to get the appropriate position for the new slope, so the rectangle doesn't jump.
        return oldyi * ratio;
    }
}

struct Paddle
{
    int paddle1_y = (HEIGHT / 2) - 50;
    int paddle2_y = (HEIGHT / 2) - 50;

    int paddle_width = 10;
    int paddle_height = 100;
    int paddle_speed = 2;

    public void drawPaddles()
    {
        DrawRectangleV(Vector2(HEIGHT / 15, paddle1_y), Vector2(paddle_width, paddle_height), Colors
                .WHITE);
        DrawRectangleV(Vector2(WIDTH - (HEIGHT / 15), paddle2_y), Vector2(paddle_width, paddle_height), Colors
                .WHITE);
    }
}

struct Background
{
    Color background_color = Colors.LIGHTGRAY;

    void drawBackground()
    {
        //This loop draws the different sides of the pong court. The loop starts at -1 opposed to 0 to have the first square not be drawn.
        for (int i = -1; i < 30; i += 2)
        {
            //I looked at an image of pong, and the height was 30 of these squares tall, hence why static_block_size appears often.
            DrawRectangleV(Vector2(WIDTH / 2 + (static_block_size) / 4, i * (static_block_size)), Vector2(
                    static_block_size, static_block_size), Colors
                    .LIGHTGRAY);
        }
        //Draw the top border and bottom border
        DrawRectangleV(Vector2(0, 0), Vector2(WIDTH, static_block_size), background_color);
        DrawRectangleV(Vector2(0, HEIGHT - static_block_size), Vector2(WIDTH, static_block_size), Colors
                .LIGHTGRAY);
    }
}

void main()
{
    Game game = Game();
    game.initialize();
}


struct Game {
    public void initialize() {
        //Create window
        InitWindow(WIDTH, HEIGHT, "Pong");
        SetTargetFPS(60);

        Projectile projectile = Projectile();
        Background background = Background();

        scope (exit)
            CloseWindow();

        //Loop which will draw the screensaver and UI while the window is not closed.
        while (!WindowShouldClose())
        {
            BeginDrawing();
            processEvents();

            background.drawBackground();

            p.drawPaddles();
            DrawText(toStringz(to!string(player_score)), WIDTH / 2 - 50, static_block_size, 50, Colors
                    .WHITE);
            DrawText(toStringz(to!string(player2_score)), WIDTH / 2 + 50, static_block_size, 50, Colors
                    .WHITE);
            if (projectile.point_scored)
            {
                if (t >= ((Clock.currTime() - SysTime.fromUnixTime(0)).total!"msecs" / 1000.0))
                {
                    // If a point is scored, draw the text "Point Scored" in the middle of the screen
                    DrawText("Point scored!", WIDTH / 2 - 165, HEIGHT / 2 - 115, 50, Colors
                            .WHITE);
                }
                else
                {
                    projectile.point_scored = false;
                    projectile.projectile_speed = 2;
                    projectile.projectile_slope = 1;
                    projectile.xi = WIDTH / 2;
                    projectile.yi = HEIGHT / 2;
                }
            }
            else
            {
                projectile.updateProjectile();
            }
            ClearBackground(Colors.BLACK);
            EndDrawing();

        }
    }

    private void processEvents()
    {
        if (IsKeyDown(KeyboardKey.KEY_S) && p.paddle1_y < HEIGHT - p.paddle_height - static_block_size)
        {
            p.paddle1_y += p.paddle_speed;
        }
        else if (IsKeyDown(KeyboardKey.KEY_W) && p.paddle1_y > static_block_size)
        {
            p.paddle1_y -= p.paddle_speed;
        }
        if (IsKeyDown(KeyboardKey.KEY_DOWN) && p.paddle2_y < HEIGHT - p.paddle_height - static_block_size)
        {
            p.paddle2_y += p.paddle_speed;
        }
        else if (IsKeyDown(KeyboardKey.KEY_UP) && p.paddle2_y > static_block_size)
        {
            p.paddle2_y -= p.paddle_speed;
        }
    }
}