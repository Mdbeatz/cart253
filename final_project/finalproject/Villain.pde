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

  ArrayList<VillainLaser> villainLaser = new ArrayList<VillainLaser>();


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

    shootsLaser();
  }

  // shootsLaser()
  //
  //
  void shootsLaser() {
    if (frameCount % floor(random(50, 800)) == 0) {
      villainLaser.add(new VillainLaser(x, y));
    }

    for (int i = 0; i < villainLaser.size(); i++) {
      villainLaser.get(i).update();
      villainLaser.get(i).display();

      //if (villainLaser.get(i).y > height) {
      //  villainLaser.remove(i);
      //}

      // A laser gets removed if it hits the planet, the superhero or the shield.
      if (dist(villainLaser.get(i).x, villainLaser.get(i).y, planetX, planetY) < planetSize/2) {
        villainLaser.remove(i);
        int planetFillAlpha = 100;
        planetFill = color (238, 174, 121, planetFillAlpha);
      } else if (dist(villainLaser.get(i).x, villainLaser.get(i).y, superhero.x, superhero.y) < superhero.superheroSize/2) {
        villainLaser.remove(i);
      } else if (abs(villainLaser.get(i).y - shieldY) < shieldHeight/2 && shieldOn == true){        
        villainLaser.remove(i);
      }
    }
  }

  // hitsWall()
  //
  //
  void hitsWall() {
    vx = -vx;
    y += (size/2);
  }

  // dies()
  //
  //
  void dies() {
    energy = 0;
    fill = color(255, 0);
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