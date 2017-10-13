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

  // The width and height of the blocker
  int blockerWidth;
  int blockerHeight;


  /////////////// Constructor ///////////////

  // Blocker(int tempX, int tempY)
  //
  // Sets the position, width and height based on arguments 
  // passed through (from the main program).
  
  Blocker(int tempX, int tempY, int tempBlockerWidth, int tempBlockerHeight) {
    x = tempX;
    y = tempY;

    blockerWidth = tempBlockerWidth;
    blockerHeight = tempBlockerHeight;
  }


  /////////////// Methods ///////////////

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