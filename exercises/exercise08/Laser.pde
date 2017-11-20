class Laser {  
  /////////////// Properties ///////////////

  int x;
  int y;
  int size;
  int speed;


  /////////////// Constructor ///////////////

  // Starfield (int tempX, int tempY, int tempVY, int tempSize)
  Laser (int x, int y, int speed) {
    this.x = x;
    this.y = y;
    this.speed = speed;

    size = 4;
  }


  /////////////// Methods ///////////////

  // update()
  //
  //
  void update() {
    y = y - speed;
  }

  // display()
  //
  //
  void display() {
    noStroke();
    fill(255, 0, 0);
    ellipse(x, y, size, size);
  }
}