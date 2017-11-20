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


  /////////////// Constructor ///////////////

  // Laser()
  //
  //

  Laser () {
    x = superhero.x;
    y = superhero.y;
    size = 20;
    speed = 8;
  }


  /////////////// Methods ///////////////

  // update()
  //
  // Move the laser upwards.
  void update() {
    // Subtract the laser's current speed from its y-position
    y -= speed;
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