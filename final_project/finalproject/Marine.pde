class Marine {

  /////////////// Properties ///////////////

  int x;
  int y;

  int vx;
  int speed = 10;

  int marineWidth = 60;
  int marineHeight = 60;


  /////////////// Constructor ///////////////

  // Marine(int tempX, int tempY, char tempLeftKey, char tempRightKey)
  //
  // Sets the position and controls based on arguments.
  // Starts velocity at 0.

  Marine (int tempX, int tempY) {
    x = tempX;
    y = tempY;

    vx = 0;
  }
}