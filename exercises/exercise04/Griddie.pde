// Griddie
//
// A class defining the behaviour of a single Griddie
// which can move randomly in the window (within the grid),
// loses energy per move, and gains energy from overlapping
// with another Griddie. It also gets bigger in size and
// changes color from overlapping with a Dottie.

class Griddie {
  // Limits for energy level and gains/losses
  int maxEnergy = 255;
  int moveEnergy = -1;
  int collideEnergy = 10;

  // Position, size, energy, and fill color
  int x;
  int y;
  int size;
  int energy;
  color fill = color(255, 0, 0);

  // Griddie(tempX, tempY, tempSize)
  //
  // Set up the Griddie with the specified location and size
  // Initialise energy to the maximum
  Griddie(int tempX, int tempY, int tempSize) {
    x = tempX;
    y = tempY;
    size = tempSize;
    energy = maxEnergy;
  }

  // update()
  //
  // Move the Griddie and update its energy levels
  void update() {

    // QUESTION: What is this if-statement for?
    // Checks if the griddie ran out of energy / has died. 
    // Returns TRUE is it did, returns FALSE if it did not.
    if (energy == 0) {
      return;
    }

    // QUESTION: How does the Griddie movement updating work?
    // The griddies movement is updated randomly 
    int xMoveType = floor(random(-1, 2));
    int yMoveType = floor(random(-1, 2));
    x += size * xMoveType;
    y += size * yMoveType;

    // QUESTION: What are these if statements doing?
    // Checking if the griddie is exiting the window. If it goes off the left side,
    // it'll come back through the right side, and vice versa. If it goes off the top of the window, 
    // it'll come back through the bottom of the window, and vice versa.
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

    // Update the Griddie's energy
    // Note that moveEnergy is negative, so this _loses_ energy
    energy += moveEnergy;

    // Constrain the Griddies energy level to be within the defined bounds
    energy = constrain(energy, 0, maxEnergy);
  }

  // collide(other)
  //
  // Checks for collision with the other Griddie
  // and updates energy level
  void collide(Griddie other) {
    // QUESTION: What is this if-statement for?
    // Checks if the Griddie's energy is EQUAL to 0 OR if the other Griddie's
    // energy is EQUAL to 0. If either of them are true, this statement will return TRUE.
    // If a griddie is dead, then another griddie cannot gain energy from it.
    if (energy == 0 || other.energy == 0) {
      return;
    }

    // QUESTION: What does this if-statement check?
    // Checks if the Griddie's x and y coordinates are EQUAL to the 
    // x and y coordinates of the "other" Griddie it is colliding with.
    if (x == other.x && y == other.y) {
      // Increase this Griddie's energy
      energy += collideEnergy;
      // Constrain the energy level to be within bounds
      energy = constrain(energy, 0, maxEnergy);
    }
  }

  // ADDED
  // collide(other)
  //
  // 
  void collide (Dottie other) {
    // Checks if a Griddie (with energy not equal to 0) has collided with a cyan Dottie
    // If they have collided, the Griddie's fill color will change to orange and the Griddie will get bigger.
    if (energy != 0 && x == other.x && y == other.y && other.fill == color(0, 255, 255)) {
      // Set fill color to orange
      fill = color(255, 165, 0);

      // Set size to the new grid size
      size = newGridSize;
    }

    // Checks if a Griddie (with energy not equal to 0) has collided with a magenta Dottie
    // If they have collided, the Griddie's fill color will change to lime green and the Griddie will get bigger.
    if (energy != 0 && x == other.x && y == other.y && other.fill == color(255, 0, 255)) {
      // Set fill color to lime green
      fill = color(0, 255, 0);

      // Set size to the new grid size
      size = newGridSize;
    }

    // Checks if a Griddie (with energy not equal to 0) has collided with a yellow Dottie
    // If they have collided, the Griddie's fill color will change to white and the Griddie will get bigger.
    if (energy != 0 && x == other.x && y == other.y && other.fill == color(255, 255, 0)) {
      // Set fill color to white
      fill = color(255);

      // Set size to the new grid size
      size = newGridSize;
    }
  }

  // display()
  //
  // Draw the Griddie on the screen as a rectangle
  void display() {
    // ADDED
    rectMode(CENTER);

    // QUESTION: What does this fill line do?
    // Sets the fill color for the Griddie. Uses the RGB values stored in the fill property, 
    // and uses the value stored in the energy property for the alpha value (the opacity of the fill).
    // and basically displays how much energy the griddie has left. 
    fill(fill, energy); 
    noStroke();
    rect(x, y, size, size);
  }
}