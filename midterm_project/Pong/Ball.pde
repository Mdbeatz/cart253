// Ball
//
// A class that defines a ball that can move around in the window, bouncing
// of the top and bottom, and can detect collision with a paddle and bounce off that.

class Ball {

  /////////////// Properties ///////////////

  // Default values for speed and size
  int SPEED = 5;
  int SIZE;

  // CHANGED
  // The new velocity for the newly restarted game
  int newSPEED = 6;

  float time = 0.1;
  float increment = 0.04;

  // The location of the ball
  int x;
  int y;

  // The velocity of the ball
  int vx;
  int vy;

  // The colour of the ball
  color ballColor = color(255);


  /////////////// Constructor ///////////////

  // Ball(int _x, int _y)
  //
  // The constructor sets the variable to their starting values
  // x and y are set to the arguments passed through (from the main program)
  // and the velocity starts at SPEED for both x and y 
  // (so the ball starts by moving down and to the right)
  // NOTE that I'm using an underscore in front of the arguments to distinguish
  // them from the class's properties

  Ball(int _x, int _y) {
    x = _x;
    y = _y;
    vx = SPEED;
    vy = SPEED;
  }


  /////////////// Methods ///////////////

  // update()
  //
  // This is called by the main program once per frame. It makes the ball move
  // and also checks whether it should bounce of the top or bottom of the screen
  // and whether the ball has gone off the screen on either side.

  void update() {
    // First update the location based on the velocity (so the ball moves)
    x += vx;
    y += vy;

    // Check if the ball is going off the top of bottom
    if (y - SIZE/2 < 0 || y + SIZE/2 > height) {
      // If it is, then make it "bounce" by reversing its velocity
      vy = -vy;
    }
  }

  // reset()
  //
  // Resets the ball to the centre of the screen width wise, 
  // but it will randomly assign the y coordinate.
  // Note that it KEEPS its velocity

  void reset() {
    x = width/2;
    
    // CHANGED
    // Set the y coordinate to a random integer within the height of the window
    y = (int) random(height);
  }

  // CHANGED
  // isOffScreen()
  //
  // Returns true if the ball is off the left or right side of the window, otherwise false.
  // Adds 1 to the right player's score if the ball is off the left side of the window.
  // Adds 1 to the left player's score if the ball is off the right side of the window. 

  boolean isOffScreen() {
    //return (x + SIZE/2 < 0 || x - SIZE/2 > width);

    // CHANGED
    // Check if the ball is off the left side of the window by checking if it's location is less than 0.
    if (x + SIZE/2 < 0) {
      // If it is, make the right player's score increase by 1
      rightScore++;

      if (leftPaddle.HEIGHT > 40) {
        leftPaddle.HEIGHT = leftPaddle.HEIGHT-10;
      }    

      return true;
    } // Check if the ball is off the right side of the window by checking if it's location is greater than the width of the window.
    else if (x - SIZE/2 > width) {
      // If it is, make the left player's score increase by 1
      leftScore++;

      if (rightPaddle.HEIGHT > 40) {
        rightPaddle.HEIGHT = rightPaddle.HEIGHT-10;
      }

      return true;
    } else {
      // If all is not true, return false.
      return false;
    }
  }

  // collide(Paddle paddle)
  //
  // Checks whether this ball is colliding with the paddle passed as an argument
  // If it is, it makes the ball bounce away from the paddle by reversing its
  // x velocity

  void collide(Paddle paddle) {
    // Calculate possible overlaps with the paddle side by side
    boolean insideLeft = (x + SIZE/2 > paddle.x - paddle.WIDTH/2);
    boolean insideRight = (x - SIZE/2 < paddle.x + paddle.WIDTH/2);
    boolean insideTop = (y + SIZE/2 > paddle.y - paddle.HEIGHT/2);
    boolean insideBottom = (y - SIZE/2 < paddle.y + paddle.HEIGHT/2);

    // Check if the ball overlaps with the paddle
    if (insideLeft && insideRight && insideTop && insideBottom) {
      // If it was moving to the left
      if (vx < 0) {
        // Reset its position to align with the right side of the paddle
        x = paddle.x + paddle.WIDTH/2 + SIZE/2;
      } else if (vx > 0) {
        // Reset its position to align with the left side of the paddle
        x = paddle.x - paddle.WIDTH/2 - SIZE/2;
      }
      // And make it bounce
      vx = -vx;

      // CHANGED
      // An array of colors (white, black and grey)
      color[] ballColors = {color(255), color(0), color(128, 128, 128)};

      // CHANGED
      // Set the ball's fill color randomly to either white, black or grey
      ballColor = ballColors[(int)random(3)];
    }
  }

  void collidesWithBlocker(Blocker blocker) {
    boolean hitsLeft = (x + SIZE/2 > blocker.x - blocker.blockerWidth/2);
    boolean hitsRight = (x - SIZE/2 < blocker.x + blocker.blockerWidth/2);
    boolean hitsTop = (y + SIZE/2 > blocker.y - blocker.blockerHeight/2);
    boolean hitsBottom = (y - SIZE/2 < blocker.y + blocker.blockerHeight/2);

    if (hitsLeft && hitsRight && hitsTop && hitsBottom) {
      // If it was moving to the left
      if (vx < 0) {
        // Reset its position to align with the right side of the paddle
        x = blocker.x + blocker.blockerWidth/2 + SIZE/2;
      } else if (vx > 0) {
        // Reset its position to align with the left side of the paddle
        x = blocker.x - blocker.blockerWidth/2 - SIZE/2;
      }
      // And make it bounce
      vx = -vx;
    }
  }

  // display()
  //
  // Draw the ball at its position

  void display() {
    // Set up the appearance of the ball (no stroke and the fill color is called)
    noStroke();
    fill(ballColor);

    // CHANGED
    // 
    float noiseValue = noise(time) * (width/7);

    // CHANGED rect to ellipse
    // Draw the ball
    ellipse(x, y, noiseValue, noiseValue);

    time += increment;
  }
}