// Dottie
//
// A class defining the behaviour of a single Dottie.

class Dottie {
  // Position, size, and fill color
  int x;
  int y;
  int size;
  color fill = color(255);

  // Dottie (tempX, tempY, tempSize)
  //
  // Set up the Griddie with the specified location and size
  Dottie (int tempX, int tempY, int tempSize) {
    x = tempX;
    y = tempY;
    size = tempSize;
  }

  // update()
  //
  // Move the Dottie
  void update() {
    // Set the griddies movement to update randomly 
    int xMoveType = floor(random(-1, 2));
    int yMoveType = floor(random(-1, 2));
    x += size * xMoveType;
    y += size * yMoveType;

    // Checking if the Dottie is exiting the window and if it is,
    // it will be put back inside the bounds of the window.
    if (x < 0) {
      x += width;
    } else if (x >= width) {
      x -= width;
    }
    if (y < 0) {
      y += height;
    } else if (y >= height) {
      y -= height;
    }
  }

  // display()
  //
  // Draw the Dottie on the screen as a circle
  void display() {
    fill(fill);
    noStroke();
    ellipse(x, y, size, size);
  }
}