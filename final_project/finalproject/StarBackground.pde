// StarBackground
//
// The star background.

class StarBackground {
  /////////////// Properties ///////////////

  // Position, y-velocity and size of the stars
  int x;
  int y;
  int vy;
  int size;

  // Array of colors (white & yellowish-white & light-cyan)
  color[] starColors = {color(255, 255, 255), color(255, 255, 235), color(200, 255, 255)};

  // Set the fill to be a random color from the array of bubbleColors
  color fill = starColors[(int)random(3)];


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
}