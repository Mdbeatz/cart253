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

int fillColourCount; // Declared an int named fillColourCount to store/hold the count of how many times the fill colour changes

// setup()
//
// Sets the size, circle location, velocity, stroke, fill and background.
void setup() {
  size(640, 480); // sets the size of the window
  circleX = width/2; // assigns circleX the value of half the width of the window
  circleY = height/2; // assigns circleY the value of half the height of the window
  circleVX = CIRCLE_SPEED; // assigns the value of CIRCLE_SPEED, which is 7
  circleVY = CIRCLE_SPEED; // assigns the value of CIRCLE_SPEED, which is 7
  stroke(STROKE_COLOR); // assigns the value of STROKE_COLOR to the stroke, which is (250, 150, 150)
  fill(NO_CLICK_FILL_COLOR); // assigns the fill colour of the circle, which is (250, 100, 100)
  background(BACKGROUND_COLOR); // assigns the background colour, which is (250, 150, 150)
}

// draw()
//
// where the magic happens
void draw() {
  // if the mouse position is in the center of the circle, then the circles
  // will change colour for as long as the mouse stays in the center
  if (dist(mouseX, mouseY, circleX, circleY) < CIRCLE_SIZE/2) {
    fill(CLICK_FILL_COLOR);
    
    fillColourCount++;
    // Changes the fill colour when it is in the center of the circle to yellow after it's been changed 20 times
    if (fillColourCount > 20) {
      fill(255, 255, 0);
    }
  } else {
    fill(NO_CLICK_FILL_COLOR);
  }
  
  // if the mouse position is anywhere in the bottom right corner the circle size will increase,
  // else, the circle will be created with the values being called
  if (mouseX > (width/2) && mouseY > (height/2)) {
    ellipse(circleX, circleY, 80, 80);
  } else {
    ellipse(circleX, circleY, CIRCLE_SIZE, CIRCLE_SIZE); // creates the circle starting in the middle of the window and with a size of 50
  }
  
  circleX += circleVX; 
  circleY += circleVY;
  
  // Stops the circle from exiting the window from the left or right
  // Uses a negative velocity so the circle "bounces" off the left and right sides of the window
  if (circleX + CIRCLE_SIZE/2 > width || circleX - CIRCLE_SIZE/2 < 0) {
    circleVX = -circleVX;
  }
  
  // Stops the circle from exiting the window from the top or bottom
  // Uses a negative velocity so the circle "bounces" off the top and bottom sides of the window
  if (circleY + CIRCLE_SIZE/2 > height || circleY - CIRCLE_SIZE/2 < 0) {
    circleVY = -circleVY;
  }
}

// mousePressed()
// 
// Called when the mouse button goes down
// Resets the window
void mousePressed() {
  //background(BACKGROUND_COLOR); // resets the window with the original background colour of (250, 150, 150)
  background(random(250), random(250), random(250)); // assigns a random RGB value for the background so a random bg colour appears every time a user clicks
  fillColourCount = 0; // Resets the count to 0 so it can start over again once the window is refreshed
}

// keyPressed()
//
// Called when any key is pressed
// Resets the window
void keyPressed() {
  background(random(250), random(250), random(250)); // assigns a random RGB value for the background so a random bg colour appears every time a user clicks
  fillColourCount = 0; // Resets the count to 0 so it can start over again once the window is refreshed
}