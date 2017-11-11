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

  // keyPressed()
  //
  // 
  void keyPressed() {
    // Check if the key is our left key
    if (keyCode == LEFT) {
      // If it is, we want a negative x velocity
      vx = -speed;
    } // Otherwise, check if the key is our right key
    else if (keyCode == RIGHT) {
      // If it is, we want a positive x velocity
      vx = speed;
    }
  }

  // keyReleased()
  //
  // 
  void keyReleased() {
    // Check if the key is our left key and if Marine is moving to the left
    if (keyCode == LEFT && vx < 0) {
      // If it is, Marine should stop
      vx = 0;
    } // Otherwise, check if the key is our right key and if Marine is moving to the right
    else if (keyCode == RIGHT && vx > 0) {
      // It if is, Marine should stop
      vx = 0;
    }
  }
}