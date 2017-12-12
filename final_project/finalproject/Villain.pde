// Villain
//
// A class that defines a villain that moves along the x-axis and shifts downwards
// every time it collides with the left or right wall of the window

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
    if (frameCount % floor(random(100, 200)) == 0) {
      villainLaser.add(new VillainLaser(x, y));
      
      villainLaserSound.play();
      villainLaserSound.amp(0.5);
    }

    for (int i = 0; i < villainLaser.size(); i++) {
      villainLaser.get(i).update();
      villainLaser.get(i).display();

      // A laser gets removed if it hits the planet, the superhero or the shield.
      if (dist(villainLaser.get(i).x, villainLaser.get(i).y, planet.planetX, planet.planetY) < planet.planetSize/2 ) {
        villainLaser.remove(i);

        if (planet.planetFillAlpha > 10) {
          planet.planetFillAlpha = planet.planetFillAlpha - 15;
        } else {
          gameScreen = 2;
          
          gameOverSound.play();
        }
      } else if (dist(villainLaser.get(i).x, villainLaser.get(i).y, superhero.x, superhero.y) < superhero.superheroSize/2) {
        villainLaser.remove(i);

        // Check if the hearts ArrayList is EQUAL to 1
        if (heartsSize == 1) {
          // If it is, the gameScreen value becomes 2 (therefore displays the gameOverScreen)
          gameScreen = 2;
          
          gameOverSound.play();
        } else {
          // Otherwise, remove a heart from the hearts ArrayList
          // Loop through the hearts ArrayList
          heartsSize--;
        }
      } else if (abs(villainLaser.get(i).y - shieldY) < shieldHeight/2 && shieldOn == true && villainLaser.get(i).x > shieldX - shieldWidth/2 && villainLaser.get(i).x < shieldX + shieldWidth/2) {        
        villainLaser.remove(i);
      }
    }
  }

  // reachesSuperhero()
  //
  //
  void reachesSuperhero() {
    if (y > height - superheroInset - 150) {
      gameScreen = 2;
    }
  }

  // hitsWall()
  //
  //
  void hitsWall() {
    vx = -vx;
    y += 70;
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
    //ellipse(x, y, size, size);

    image(villainSprite, x, y, size, size);
  }
}