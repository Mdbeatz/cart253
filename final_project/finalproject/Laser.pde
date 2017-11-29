// Laser
//
//

class Laser {
  /////////////// Properties ///////////////

  // Location, size and speed of the laser
  int x;
  int y;
  int size;
  int speed;

  boolean getRemoved;


  /////////////// Constructor ///////////////

  // Laser()
  //
  //

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
  //
  boolean hits(Villain villain) {
    if (dist(x, y, villain.x, villain.y) < size + villain.size/2 && villain.energy != 0) {
      return true;
    } else {
      return false;
    }
  }

  // disappear()
  //
  //
  void disappear() {
    getRemoved = true;
  }

  // display()
  //
  // Display the laser.
  void display() {
    // Red stroke
    stroke(255, 255, 0);

    // Stroke thickness
    strokeWeight(8);

    // Yellow fill
    fill(255, 0, 0);

    ellipse(x, y, size, size);
  }
}