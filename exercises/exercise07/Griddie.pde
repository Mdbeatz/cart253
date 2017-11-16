// Griddie
//
// A class defining the behaviour of a single Griddie
// which can move through the x-axis within the window,
// and can make a sound once a griddie is created.


class Griddie {

  /////////////// Properties ///////////////

  // Position, velocity and size
  int x;
  int y;
  int vx;
  int size;

  // Array of colors (white & violet)
  color[] griddieColors = {color(255, 255, 255), color(209, 137, 235)};

  // Set the fill to be a random color from the array of griddieColors
  color fill = griddieColors[(int)random(2)];


  /////////////// Constructor ///////////////

  // Griddie (int tempX, int tempY, int tempVX, int tempSize)
  //
  // Sets the position, velocity and size based on arguments.

  Griddie (int tempX, int tempY, int tempVX, int tempSize) {
    x = tempX;
    y = tempY;

    vx = tempVX;

    size = tempSize;
  }


  /////////////// Methods ///////////////

  // update()
  //
  // Move the Griddie.
  void update() {
    x += vx;

    // Check if the y value is greater than the value of the height + size.
    // Basically checks if the bubble has exited the window by the bottom 
    // and if it has, it will come back again through the top.
    if (x > width + size) {
      // If it is, the y alue is given the negative size value
      x = -size;

      y = floor(random(height));

      vx = floor(random(3, 7));
    }
  }

  // display()
  //
  // Create the Griddie on screen as a square.
  void display() {
    noStroke();
    fill(fill);
    rect(x, y, size, size);
  }


  // playSound()
  //
  // Plays the kick or snare sound depending on which griddie is displayed.
  void playSound() {
    // Checks if the griddie is white 
    if (fill == color(255, 255, 255)) {
      // If it is, kickSound will play
      kickSound.play();
    }

    // Checks if the griddie is violet
    if (fill == color(209, 137, 235)) {
      // If it is, snareSound will play
      snareSound.play();
    }
  }
}