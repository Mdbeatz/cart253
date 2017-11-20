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

  // Starfield (int tempX, int tempY, int tempVY, int tempSize)
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
  //
  void update() {
    y -= speed;

  }

  // display()
  //
  //
  void display() {
    stroke(255, 255, 0);
    strokeWeight(8);
    fill(255, 0, 0);
    ellipse(x, y, size, size);
  }
}