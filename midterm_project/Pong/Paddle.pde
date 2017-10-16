// Paddle
//
// A class that defines a paddle that can be moved up and down on the screen
// using keys passed through to the constructor.

class Paddle {

  /////////////// Properties ///////////////

  // Default values for speed and size
  int SPEED = 6; // CHANGED
  int HEIGHT = 80; // CHANGED
  int defaultHEIGHT = 80; // CHANGED
  int WIDTH = 16;

  // The position and velocity of the paddle (note that vx isn't really used right now)
  int x;
  int y;
  int vx;
  int vy;

  // CHANGED
  // The fill color of the paddle
  color paddleColor = color(0);

  // CHANGED
  // The default characters used to make the paddle move up and down, defined in constructor
  char defaultUpKey;
  char defaultDownKey;
  
  // The characters used to make the paddle move up and down
  char upKey;
  char downKey;

  /////////////// Constructor ///////////////

  // Paddle(int _x, int _y, char _upKey, char _downKey)
  //
  // Sets the position and controls based on arguments,
  // starts the velocity at 0

  Paddle(int _x, int _y, char _upKey, char _downKey) {
    // Set x value to the new temp value in _x
    x = _x;
    
    // Set y value to the new temp value in _y
    y = _y;
    
    // Set the velocity for vx and vy to 0
    vx = 0;
    vy = 0;

    // CHANGED
    // Set the default key to the control passed by the _upKey argument
    defaultUpKey = _upKey;

    // CHANGED
    // Set upKey to the new value stored in defaultUpKey
    upKey = defaultUpKey;
    
    // CHANGED
    // Set the default key to the new control passed by the _downKey argument
    defaultDownKey = _downKey;

    // CHANGED
    // Set upKey to the new value stored in defaultDownKey
    downKey = defaultDownKey;
  }


  /////////////// Methods ///////////////

  // update()
  //
  // Updates position based on velocity and constraints the paddle to the window

  void update() {
    // Update position with velocity (to move the paddle)
    x += vx;
    y += vy;

    // Constrain the paddle's y position to be in the window
    y = constrain(y, 0 + HEIGHT/2, height - HEIGHT/2);
  }

  // display()
  //
  // Display the paddle at its location

  void display() {
    // Set display properties

    // CHANGED
    // Set stroke color
    stroke(255);

    // CHANGED
    // Set stroke weight/thickness
    strokeWeight(3);

    fill(paddleColor);
    rectMode(CENTER);

    // Draw the paddle as a rectangle
    rect(x, y, WIDTH, HEIGHT);
  }

  // keyPressed()
  //
  // Called when keyPressed is called in the main program

  void keyPressed() {
    // Check if the key is our up key
    if (key == upKey) {
      // If so we want a negative y velocity
      vy = -SPEED;
    } // Otherwise check if the key is our down key 
    else if (key == downKey) {
      // If so we want a positive y velocity
      vy = SPEED;
    }
  }

  // keyReleased()
  //
  // Called when keyReleased is called in the main program

  void keyReleased() {
    // Check if the key is our up key and the paddle is moving up
    if (key == upKey && vy < 0) {
      // If so it should stop
      vy = 0;
    } // Otherwise check if the key is our down key and paddle is moving down 
    else if (key == downKey && vy > 0) {
      // If so it should stop
      vy = 0;
    }
  }
}