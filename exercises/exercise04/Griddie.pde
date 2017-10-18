// Griddie
//
// A class defining the behaviour of a single Griddie
// which can move randomly in the window (within the grid),
// loses energy per move, and gains energy from overlapping
// with another Griddie.

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
    // Checking if the griddie is exiting the window and if they are they
    // will be put back inside the bounds of the window.
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

  // display()
  //
  // Draw the Griddie on the screen as a rectangle
  void display() {
    // QUESTION: What does this fill line do?
    // Sets the fill color for the Griddie. Uses the RGB values stored in the fill property, 
    // and uses the value stored in the energy property for the alpha value (the opacity of the fill).
    // and basically displays how much energy the griddie has left.
    fill(fill, energy); 
    noStroke();
    rect(x, y, size, size);
  }
}