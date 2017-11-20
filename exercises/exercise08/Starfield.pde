class Starfield {
  /////////////// Properties ///////////////

  // Position, velocity and size
  int x;
  int y;
  int vy;
  int size;

  // Array of colors (white & yellowish-white)
  color[] starColors = {color(255, 255, 255), color(255, 255, 196)};

  // Set the fill to be a random color from the array of bubbleColors
  color fill = starColors[(int)random(2)];


  /////////////// Constructor ///////////////

  // Starfield (int tempX, int tempY, int tempVY, int tempSize)
  //
  // Sets the position, velocity and size based on arguments.

  Starfield (int x, int y, int vy, int size) {
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
    y += vy;

    // Check if the y value is greater than the value of the height + size.
    // Basically checks if the star has exited the window by the bottom 
    // and if it has, it will come back again through the top.
    if (y > height + size) {
      // If it is, the y alue is given the negative size value
      y = -size;

      x = floor(random(width));
    }
  }

  // display()
  //
  // Create the stars on screen as little circles.
  void display() {
    noStroke();
    fill(fill);

    int size2 = size;

    ellipse(x, y, size, size2);
  }
}