// Bubble
//
// A class defining the behaviour of a single Bubble
// which can move down the y-axis within the window.


class Bubble {

  /////////////// Properties ///////////////

  // Position, velocity and size
  int x;
  int y;
  int vy;
  int size;

  // Array of colors
  color[] bubbleColors = {color(230, 132, 156), color(230, 206, 132), color(132, 230, 206)};

  // Set the fill to be a random color from the array of bubbleColors
  color fill = bubbleColors[(int)random(3)];


  /////////////// Constructor ///////////////

  // Bubble (int tempX, int tempY, int tempVY, int tempSize)
  //
  // Sets the position, velocity and size based on arguments.

  Bubble (int tempX, int tempY, int tempVY, int tempSize) {
    x = tempX;
    y = tempY;

    vy = tempVY;

    size = tempSize;
  }


  /////////////// Methods ///////////////

  // update()
  //
  // Move the Bubble.
  void update() {
    y += vy;
    
    // Check if the y value is greater than the value of the height + size.
    // Basically checks if the bubble has exited the window by the bottom 
    // and if it has, it will come back again through the top.
    if (y > height + size) {
      // If it is, the y alue is given the negative size value
      y = -size;
      
      x = floor(random(width));

      vy = floor(random(3, 7));
    }
  }

  // display()
  //
  // Create the Bubble on screen as an ellipse.
  void display() {
    noStroke();
    fill(fill);
    ellipse(x, y, size, size);
  }
}