// CHANGED
//
// Blocker
//
// A class that defines a blocker (an obstacle) that can obstruct 
// the direction the ball is bouncing to.

class Blocker {

  /////////////// Properties ///////////////

  // The location of the blocker
  int x;
  int y;

  int blockerWidth;
  int blockerHeight;

  // Blocker(int tempX, int tempY)
  //
  // The constructor sets the variable to their starting values x and y 
  // are set to the arguments passed through (from the main program).

  Blocker(int tempX, int tempY, int tempBlockerWidth, int tempBlockerHeight) {
    x = tempX;
    y = tempY;

    blockerWidth = tempBlockerWidth;
    blockerHeight = tempBlockerHeight;
  }

  // display()
  //
  //
  void display() {
    // Set display properties
    noStroke();
    rectMode(CENTER);

    rect(x, y, blockerWidth, blockerHeight);
  }
}