// Dottie
//
// A class defining the behaviour of a single Dottie.

class Dottie {
  // Position, size, and energy
  int x;
  int y;
  int size;
  int energy;

  // Array of colors
  color[] dottieColors = {color(211, 96, 931), color(136, 212, 197), color(237, 196, 85)};
  
  // Set the fill to be a random color from the array of dottieColors
  color fill = dottieColors[(int)random(3)];

  // Limits for energy level and gains/losses
  int maxEnergy = 255;
  int moveEnergy = -1;
  int collideEnergy = 10;

  // Dottie (tempX, tempY, tempSize)
  //
  // Set up the Dottie with the specified location and size.
  // Initialise energy to the maximum
  Dottie (int tempX, int tempY, int tempSize) {
    x = tempX;
    y = tempY;
    size = tempSize;
    energy = maxEnergy;
  }

  // update()
  //
  // Move the Dottie
  void update() {
    // Checks if the Dottie ran out of energy / has died. 
    // Returns TRUE is it did, returns FALSE if it did not.
    if (energy == 0) {
      return;
    }

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

    // Update the Griddie's energy
    // Note that moveEnergy is negative, so this _loses_ energy
    energy += moveEnergy;

    // Constrain the Griddies energy level to be within the defined bounds
    energy = constrain(energy, 0, maxEnergy);
  }

  // collide(other)
  //
  // Checks for collision with the other Dottie and updates energy level
  void collide(Dottie other) {
    // Checks if the Dottie's energy is EQUAL to 0 OR if the other Dottie's
    // energy is EQUAL to 0. If either of them are true, this statement will return TRUE.
    // If a Dottie is dead, then another Dottie cannot gain energy from it.
    if (energy == 0 || other.energy == 0) {
      return;
    }

    // Checks if the Dottie's x and y coordinates are EQUAL to the 
    // x and y coordinates of the "other" Dottie it is colliding with.
    if (x == other.x && y == other.y) {
      // Increase this Griddie's energy
      energy += collideEnergy;
      // Constrain the energy level to be within bounds
      energy = constrain(energy, 0, maxEnergy);
    }
  }

  // display()
  //
  // Draw the Dottie on the screen as a circle
  void display() {
    fill(fill, energy);
    //noStroke();
    stroke(255, energy);
    strokeWeight(1);
    ellipse(x, y, size, size);
  }
}