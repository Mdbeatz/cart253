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


  /////////////// Methods ///////////////

  // update()
  //
  //  
  void update() {
    // Update position with velocity (to move Marine)
    x += vx;

    // Constrain Marine's x position to be in the window
    x = constrain(x, 0 + marineWidth/2, width - marineWidth/2);
  }

  // display()
  //
  //  
  void display() {
    rectMode(CENTER);
    noStroke();
    fill(51, 206, 219);
    rect(x, y, marineWidth, marineHeight);
  }
}