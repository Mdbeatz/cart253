// Laser
//
// A class that defines the superhero's laser

class Laser {
  /////////////// Properties ///////////////

  // Location, size and speed of the laser
  int x;
  int y;
  int size;
  int speed;

  // Variable to remove a laser
  boolean getRemoved;


  /////////////// Constructor ///////////////

  // Laser()
  //
  // Sets the position, size and speed

  Laser () {
    x = superhero.x;
    y = superhero.y;
    size = 15;
    speed = 15;
  }


  /////////////// Methods ///////////////

  // update()
  //
  // Move the laser upwards.
  void update() {
    // Subtract the laser's current speed from its y-position
    y -= speed;
  }

  // hits(Villain villain)
  //
  // Returns true if the laser hits a villain that is alive. Otherwise, returns false
  boolean hits(Villain villain) {
    if (dist(x, y, villain.x, villain.y) < size + villain.size/2 && villain.energy != 0) {
      return true;
    } else {
      return false;
    }
  }

  // disappear()
  //
  // Remove laser
  void disappear() {
    // Set to true
    getRemoved = true;
  }

  // display()
  //
  // Display the laser.
  void display() {
    // Yellow stroke
    stroke(224, 227, 57);

    // Stroke thickness
    strokeWeight(6);

    // Pink fill
    fill(235, 45, 120);

    ellipse(x, y, size, size);
  }
}