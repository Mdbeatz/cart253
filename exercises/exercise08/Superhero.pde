// Superhero
//
// 

class Superhero {

  /////////////// Properties ///////////////

  // Location of Superhero
  int x;
  int y;

  // Velocity of Superhero
  int vx;

  // Speed of Superhero
  int speed = 10;

  // Width and height of Superhero
  int superheroWidth = 60;
  int superheroHeight = 60;


  /////////////// Constructor ///////////////

  // Superhero(int tempX, int tempY, char tempLeftKey, char tempRightKey)
  //
  // Sets the position and controls based on arguments.
  // Starts velocity at 0.

  Superhero (int x, int y) {
    this.x = x;
    this.y = y;

    vx = 0;
  }


  /////////////// Methods ///////////////

  // update()
  //
  //  
  void update() {
    // Update position with velocity (to move the Superhero)
    x += vx;

    // Constrain Superhero's x position to be in the window
    x = constrain(x, 0 + superheroWidth/2, width - superheroWidth/2);
  }

  // display()
  //
  //  
  void display() {
    rectMode(CENTER);
    noStroke();
    fill(51, 206, 219);
    rect(x, y, superheroWidth, superheroHeight);
  }

  // keyPressed()
  //
  // 
  void keyPressed() {
    // Check if the key is our left key
    if (keyCode == LEFT) {
      // If it is, we want a negative x velocity
      vx = -speed;
    } // Otherwise, check if the key is our right key
    else if (keyCode == RIGHT) {
      // If it is, we want a positive x velocity
      vx = speed;
    }
  }

  // keyReleased()
  //
  // 
  void keyReleased() {
    // Check if the key is our left key and if the Superhero is moving to the left
    if (keyCode == LEFT && vx < 0) {
      // If it is, the Superhero should stop
      vx = 0;
    } // Otherwise, check if the key is our right key and if the Superhero is moving to the right
    else if (keyCode == RIGHT && vx > 0) {
      // It if is, the Superhero should stop
      vx = 0;
    }
  }
}