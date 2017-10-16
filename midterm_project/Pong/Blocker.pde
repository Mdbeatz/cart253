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
    // Set x to new temp x value
    x = tempX;
    
    // Set y to new temp y value
    y = tempY;

    // Set the blocker width to the new value in the temp blocker width
    blockerWidth = tempBlockerWidth;
    
    // Set the blocker height to the new value in the temp blocker height
    blockerHeight = tempBlockerHeight;
  }


  /////////////// Methods ///////////////

  // display()
  //
  // Display the blocker at its location
  
  void display() {
    // Set display properties
    noStroke();
    rectMode(CENTER);

    // Set the center X and Y coordinates of the rectangle, and call its width and height values
    rect(x, y, blockerWidth, blockerHeight);
  }
}