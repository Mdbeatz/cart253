// Assigns a background color variable
color backgroundColor = color(200, 150, 150);

// Global variable for the first bouncing ball
Bouncer bouncer;

// Global variable for the second bouncing ball
Bouncer bouncer2;

// setup()
//
// Sets the window size, calls the background color and creates the bouncing balls
void setup() {
  // Set the size
  size(640, 480);

  // Set the background color
  background(backgroundColor);

  // Create the two bouncing balls mirroring each other.
  // Set their locations, velocities, sizes, fill colors and hover colors. 
  bouncer = new Bouncer(width/2, height/2, 2, 2, 50, color(150, 0, 0, 50), color(255, 0, 0, 50));
  bouncer2 = new Bouncer(width/2, height/2, -2, 2, 50, color(0, 0, 150, 50), color(0, 0, 255, 50));
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