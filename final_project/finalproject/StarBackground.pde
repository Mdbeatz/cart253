// StarBackground
//
// A class that defines the animated star background.

class StarBackground {
  /////////////// Properties ///////////////

  // Position, y-velocity and size of the stars
  int x;
  int y;
  int vy;
  int size;

  // Array of colors (white & yellow & yellowish-white & light-cyan)
  color[] starColors = {color(255, 255, 255, 150), color(255, 255, 0, 150), color(255, 255, 235, 150), color(200, 255, 255, 150)};

  // Set the fill to be a random color from the array of bubbleColors
  color fill = starColors[(int)random(4)];


  /////////////// Constructor ///////////////

  // Starfield (int tempX, int tempY, int tempVY, int tempSize)
  //
  // Sets the position, velocity and size based on arguments.

  StarBackground (int x, int y, int vy, int size) {
    this.x = x;
    this.y = y;
    this.vy = vy;
    this.size = size;
  }


  /////////////// Methods ///////////////

  // update()
  //
  // Move the stars.
  void update() {
    // Add the star's current y-velocity to its y-position
    y += vy;

    // Check if the y value is greater than the value of the height + size.
    // Basically checks if the star has exited the window by the bottom 
    // and if it has, it will come back again through the top.
    if (y > height + size) {
      // If it is, the y value is assigned the negative size value
      y = -size;
    }
  }

  // display()
  //
  // Create the stars on screen as little circles.
  void display() {
    // The radius of the circle(star). 
    // This is done to ensure that the width and height of the circle are the same value,
    // so we have a perfect circle instead of an oval. 
    int starRadius = size;

    noStroke();
    fill(fill);
    ellipse(x, y, starRadius, starRadius);
  }
}