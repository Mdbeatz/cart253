// Laser
//
//

class VillainLaser {
  /////////////// Properties ///////////////

  // Location, size and speed of the laser
  int x;
  int y;
  int size;
  int speed;



  /////////////// Constructor ///////////////

  // Laser()
  //
  //

  VillainLaser (int newX, int newY) {
    x = newX;
    y = newY;


    size = 10;
    speed = 15;
  }


  /////////////// Methods ///////////////

  // update()
  //
  // Move the laser upwards.
  void update() {
    // Subtract the laser's current speed from its y-position
    y += speed;
  }

  // display()
  //
  // Display the laser.
  void display() {
    // Red stroke color
    stroke(255, 0, 0);
    strokeWeight(3);
    // Lime green fill
    fill(57, 255, 20);
    ellipse(x, y, size, size + size + size);
  }
}