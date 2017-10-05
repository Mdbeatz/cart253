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
  // Create the two bouncing balls mirroring each other.
  // Set their locations, velocities, sizes, fill colors and hover colors. 
  bouncer = new Bouncer(width/2, height/2, 3, 3, 50, color(150, 117, 242, 50), color(117, 209, 242, 50));
  bouncer2 = new Bouncer(width/2, height/2, -3, 3, 50, color(209, 242, 117, 50), color(242, 117, 209, 50));
}

// draw()
//
// Where the magic happens.
void draw() {
  // Update the two bouncing balls by calling their update methods
  bouncer.update();
  bouncer2.update();

  // CHANGED
  // If the mouse is pressed, than the bouncer that is being clicked will get bigger in size.
  // Clicking anywhere in the window will return the bouncers to their default size.
  // If the other bouncer that is still the default size is clicked, it will get bigger, 
  // and it will make the other bouncer (if the other bouncer was turned bigger) return to its default size.
  if (mousePressed == true) {
    bouncer.mouseClicked();
    bouncer2.mouseClicked();
  }

  // Create the two bouncing balls by calling their draw methods
  bouncer.draw();
  bouncer2.draw();
}

// CHANGED
// keyPressed()
//
// Resets the window by changing the background color.
void keyPressed() {
  // If the return key (enter key) is pressed, the window resets with the background color
  if (keyCode == ENTER) {
    background(backgroundColor);
  }
}