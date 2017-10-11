// CHANGED
// Assigns a background color variable
color backgroundColor = color(246, 185, 164);

// Global variable for the first bouncing ball
Bouncer bouncer;

// Global variable for the second bouncing ball
Bouncer bouncer2;

// setup()
//
// Sets the window size, calls the background color and creates the bouncing balls
void setup() {
  // Set the size
  // CHANGED
  size(700, 500);

  // Set the background color
  background(backgroundColor);

  // CHANGED fill and hover colors
  // CHANGED velocity values
  // Create the two bouncing balls.
  // Set their locations, velocities, sizes, fill colors and hover colors. 
  bouncer = new Bouncer(width/2, height/2, 3, 3, 50, color(150, 117, 242, 50), color(117, 209, 242, 50), color(255, 255, 255, 50));
  bouncer2 = new Bouncer(width/2, height/2, -3, 3, 50, color(209, 242, 117, 50), color(242, 117, 209, 50), color(0, 0, 0, 50));
}

// draw()
//
// Where the magic happens.
void draw() {
  // Update the two bouncing balls by calling their update methods
  bouncer.update();
  bouncer2.update();

  // Create the two bouncing balls by calling their draw methods
  bouncer.draw();
  bouncer2.draw();
}

// CHANGED
// mouseClicked()
//
// Checks if the mouse is clicked on the balls.
// If a ball is clicked, it will get bigger and its color will change.
void mouseClicked() {
  bouncer.mouseClicked();
  bouncer2.mouseClicked();
}

// CHANGED
// keyPressed()
//
// Resets the window by changing the background color.
void keyPressed() {
  // Check if the SHIFT key is pressed
  if (keyCode == SHIFT) {
    // If it is, reset the window with the background color
    background(backgroundColor);
    
    // Balls will also return to their default size
    bouncer.size = bouncer.defaultSize;
    bouncer2.size = bouncer2.defaultSize;
  }
}