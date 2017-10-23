// Dottie
//
// A class defining the behaviour of a single Dottie
// which can move randomly in the window, loses energy per move,
// and gains energy from overlapping with another Dottie.

class Dottie {
  // Position, size, and energy
  int x;
  int y;
  int size;
  int energy;

  // ADDED
  // Probabilities for 3 different cases
  float cyanProbability = 0.25;      // 25% chance of cyan color
  float magentaProbability = 0.60;   // 60% chance of magenta color
  float yellowProbability = 0.15;    // 15% chance of yellow color

  // ADDED
  // Sets a random number between 0 and 1
  float num = random(1);

  int randomFill;

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

    // Checking if the dottie is exiting the window. If it goes off the left side,
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

    // Check if the random num is less than 0.25
    if (num < cyanProbability) {
      // If it is, change randomFill to cyan
      randomFill = color(0, 255, 255);

      // Check if the random num is between 0.60 and 0.25
    } else if (num < magentaProbability + cyanProbability) {
      // If it is, change randomFill to magenta
      randomFill = color(255, 0, 255);

      // Check for all other cases, between 0.85 and 1.00
    } else {
      // If it is, change randomFill to yellow
      randomFill = color(255, 255, 0);
    }

    fill(randomFill, energy);
    stroke(255, energy);
    strokeWeight(1);
    ellipse(x, y, size, size);
  }
}