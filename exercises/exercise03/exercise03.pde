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
  size(640, 480);

  // Set the background color
  background(backgroundColor);

  // CHANGED fill and hover colors
  // Create the two bouncing balls mirroring each other.
  // Set their locations, velocities, sizes, fill colors and hover colors. 
  bouncer = new Bouncer(width/2, height/2, 2, 2, 50, color(150, 117, 242, 50), color(117, 209, 242, 50));
  bouncer2 = new Bouncer(width/2, height/2, -2, 2, 50, color(209, 242, 117, 50), color(242, 117, 209, 50));
}

// draw()
//
// Where the magic happens.
void draw() {
  // Update the two bouncing balls by calling their update methods
  bouncer.update();
  bouncer2.update();
  
  bouncer.mouseClicked();
  bouncer2.mouseClicked();

  // Create the two bouncing balls by calling their draw methods
  bouncer.draw();
  bouncer2.draw();
}

//void mouseClicked() {
  
//}