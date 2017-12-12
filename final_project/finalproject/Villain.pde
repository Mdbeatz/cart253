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

  // ArrayList for villain lasers
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
  // Move the laser downwards
  void update() {
    x += vx;

    shootsLaser();
  }

  // shootsLaser()
  //
  // Shoot villain laser
  void shootsLaser() {
    if (frameCount % floor(random(100, 200)) == 0) {
      villainLaser.add(new VillainLaser(x, y));

      villainLaserSound.play();
      villainLaserSound.amp(0.3);
    }

    // Loop through the villainLaser size
    for (int i = 0; i < villainLaser.size(); i++) {
      // Update and display the indexed villain laser
      villainLaser.get(i).update();
      villainLaser.get(i).display();

      // A laser gets removed if it hits the planet, the superhero or the shield.
      if (dist(villainLaser.get(i).x, villainLaser.get(i).y, planet.planetX, planet.planetY) < planet.planetSize/2 ) {
        // Remove indexed villain laser once it has hit the planet
        villainLaser.remove(i);

        // Play planet gets hit sound
        planetGetsHitSound.play();

        // Check if the alpha channel is greater than 10
        if (planet.planetFillAlpha > 10) {
          // If it is, decrement the planetFillAlpha by 15
          planet.planetFillAlpha = planet.planetFillAlpha - 15;
        } else {
          // Otherwise, display the game over screen
          gameScreen = 2;

          // Play the game over sound
          gameOverSound.play();
        }
      } else if (dist(villainLaser.get(i).x, villainLaser.get(i).y, superhero.x, superhero.y) < superhero.superheroSize/2) {
        villainLaser.remove(i);

        superheroGetsHitSound.play();

        // Check if the hearts ArrayList is EQUAL to 1
        if (heartsSize == 1) {
          // If it is, the gameScreen value becomes 2 (therefore displays the gameOverScreen)
          gameScreen = 2;

          // Play the game over sound
          gameOverSound.play();
        } else {
          // Otherwise, remove a heart from the hearts ArrayList
          // Loop through the hearts ArrayList
          heartsSize--;
        }
      } else if (abs(villainLaser.get(i).y - shieldY) < shieldHeight/2 && shieldOn == true && villainLaser.get(i).x > shieldX - shieldWidth/2 && villainLaser.get(i).x < shieldX + shieldWidth/2) {        
        // Remvoe the indexed villain laser
        villainLaser.remove(i);
      }
    }
  }

  // reachesSuperhero()
  //
  // Checks if the villains have reached the superhero
  void reachesSuperhero() {
    if (y > height - superheroInset - 150) {
      // If the villains have reached, game over
      gameScreen = 2;
    }
  }

  // hitsWall()
  //
  // What to do if the villain's hit the side of the window
  void hitsWall() {
    // Negative x-velocity to move the other way
    vx = -vx;
    
    // Increment by 70
    y += 70;
  }

  // dies()
  //
  // What to do if the villain dies
  void dies() {
    // Set energy to 0
    energy = 0;
    
    // Set fill to white and alpha channel to 0 so it cannot be seen
    fill = color(255, 0);

    // Play villain dies sound with an amplitude/volume of 0.5
    villainDiesSound.play();
    villainDiesSound.amp(0.5);
  }

  // display()
  //
  // Display the villain
  void display() {
    noStroke();
    fill(fill);

    image(villainSprite, x, y, size, size);
  }
}