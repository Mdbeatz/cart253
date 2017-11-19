class Starfield {
  /////////////// Properties ///////////////

  // Position, velocity and size
  int x;
  int y;
  int vy;
  int size;

  // Array of colors (blueish-white & almost-white & yellowish-white & yellowish-orange & orange-redish)
  color[] starColors = {color(191, 204, 255), color(247, 243, 255), color(255, 241, 229), color(253, 200, 147), color(253, 192, 96)};

  // Set the fill to be a random color from the array of bubbleColors
  color fill = starColors[(int)random(5)];
  

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
}