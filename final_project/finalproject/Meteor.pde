// Meteor
//
// A class that defines a meteor (for level 2) that spawns from the top
// that can moves around in the window, bouncing from the left and right,
// and can detect collision with the shield and bounce off that, and can
// detect collision with the planet, which ends the game.

class Meteor {
  /////////////// Properties ///////////////

  // Location, velocity, speed and size of the meteor
  int x;
  int y;
  int vx;
  int vy;
  int speed;
  int size;


  /////////////// Constructor ///////////////

  // Meteor()
  //
  // Sets the position, speed, x and y velocities, and size
  Meteor() {
    // Set to half the value of the width of the window
    x = width/2;
    
    y = 0;

    speed = 5;

    vx = speed;
    vy = speed;

    size = 80;
  }


  /////////////// Methods ///////////////

  // reset()
  //
  // Reset the meteor to the top of the screen
  void reset() {
    // random value between 0 and the width of the screen
    x = floor(random(10, width-10));

    // The top of the screen
    y = 0;
  }

  // update()
  //
  // Move the meteor
  void update() {
    x += vx;
    y += vy;
  }

  // collide()
  //
  // Checks whether this meteor is colliding with the shield, 
  // or with the walls, or with the planet
  void collide() {

    // Check if the meteor collides with the shield
    if (abs(y - shieldY) < shieldHeight/2 && shieldOn == true && x > shieldX - shieldWidth/2 && x < shieldX + shieldWidth/2) {
      // If it is, make it bounce with a negative vy
      vy = -vy;
    }

    // Check if the meteor collides with the right or left side of the window
    if (x + size/2 > width || x - size/2 < 0) {
      // If it is, make it bounce with a negative vx
      vx = -vx;

      // Check if the meteor collides with the top of the window
    } else if (y + size/2 < 0) {  
      // If it is, make it bounce with a negative vy
      vy = -vy;

      // Check if the meteor has exited the screen by the bottom of the window
    } else if (y - size/2 > height) {
      // If it has, then reset the position of the meteor
      reset();
    }

    // Check if the meteor collides with the planet
    if (dist(x, y, planet.planetX, planet.planetY) < planet.planetSize/2 ) {
      // If it has, then set gameScreen to 2 (the game is over)
      gameScreen = 2;
    }
  }

  // display()
  //
  // Display the meteor
  void display() {
    image(meteorSprite, x, y, size, size);
  }
}