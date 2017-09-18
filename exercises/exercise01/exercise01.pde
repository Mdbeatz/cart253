final int CIRCLE_SPEED = 7; // Declares an int named CIRCLE_SPEED, assigns the value 7
final color NO_CLICK_FILL_COLOR = color(250, 100, 100); // Declares a color named NO_CLICK_FILL_COLOR, assigns the colour (250, 100, 100)
final color CLICK_FILL_COLOR = color(100, 100, 250); // Declares a color named CLICK_FILL_COLOR, assigns the colour (100, 100, 250)
final color BACKGROUND_COLOR = color(250, 150, 150); // Declares a color named BACKGROUND_COLOR, assigns the colour (250, 150, 150)
final color STROKE_COLOR = color(250, 150, 150); // Declares a color named STROKE_COLOR, assigns the colour (250, 150, 150)
final int CIRCLE_SIZE = 50; // Declares an int named CIRCLE_SIZE, assigns the value 50

int circleX; // Declares an int named circleX, the x coordinate of the center of the circle
int circleY; // Declares an int named circleY, the y coordinate of the center of the circle
int circleVX; // Declares an int named circleVX for horizontal velocity
int circleVY; // Declares an int named circleVY for vertical velocity

// setup()
//
// Sets the size, circle location, velocity, stroke, fill and background.
void setup() {
  size(640, 480); // sets the size of the window
  circleX = width/2; // assigns circleX the value of half the width of the window
  circleY = height/2; // assigns circleY the value of half the height of the window
  circleVX = CIRCLE_SPEED; // assigns the value of CIRCLE_SPEED of 7
  circleVY = CIRCLE_SPEED;
  stroke(STROKE_COLOR);
  fill(NO_CLICK_FILL_COLOR);
  background(BACKGROUND_COLOR);
}

// draw()
//
// Draws
void draw() {
  if (dist(mouseX, mouseY, circleX, circleY) < CIRCLE_SIZE/2) {
    fill(CLICK_FILL_COLOR);
  } else {
    fill(NO_CLICK_FILL_COLOR);
  }
  ellipse(circleX, circleY, CIRCLE_SIZE, CIRCLE_SIZE);
  circleX += circleVX;
  circleY += circleVY;
  if (circleX + CIRCLE_SIZE/2 > width || circleX - CIRCLE_SIZE/2 < 0) {
    circleVX = -circleVX;
  }
  if (circleY + CIRCLE_SIZE/2 > height || circleY - CIRCLE_SIZE/2 < 0) {
    circleVY = -circleVY;
  }
}

// mousePressed()
// 
// Declares what happens the mouse is pressed/clicked
void mousePressed() {
  background(BACKGROUND_COLOR); // resets the window with the original background colour of (250, 150, 150)
}