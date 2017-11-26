// Villain
//
//

class Villain {
  /////////////// Properties ///////////////

  // Position, velocity, speed, width and height of the Villain
  int x;
  int y;
  int vx;
  int vy;
  int speed;
  int size;

  int energy = 255;

  // Array of different lime green colors
  color[] villainColors = {color(50, 205, 50, energy), color(160, 232, 160, energy), color(42, 173, 42, energy)};

  // Set the fill to be a random color from the array of villainColors
  color fill = villainColors[(int)random(3)];


  /////////////// Constructor ///////////////

  // Villain (int x, int y, int speed, int size)
  //
  // Sets the position, speed and size based on arguments.
  
  Villain(int x, int y, int speed, int size) {
    this.x = x;
    this.y = y;
    this.speed = speed;
    this.size = size;

    vx = speed;
    vy = speed;
  }


  /////////////// Methods ///////////////

  // update()
  //
  //
  void update() {
    x += vx;
  }

  // hitsWall()
  //
  //
  void hitsWall() {
    vx = -vx;
    y += (size/2);
  }

  void dies() {
    energy = 0;
  }

  // display()
  //
  //
  void display() {
    noStroke();
    fill(fill);
    ellipse(x, y, size, size);
  }
}