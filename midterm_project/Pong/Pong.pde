// Pong
//
// A simple version of Pong using object-oriented programming.
// Allows to people to bounce a ball back and forth between
// two paddles that they control.
//
// Only two paddles. (So far!)

// Global variables for the paddles and the ball
Paddle leftPaddle;
Paddle rightPaddle;
Ball ball;

// The distance from the edge of the window a paddle should be
int PADDLE_INSET = 8;

// CHANGED 
// The score for the left player
int leftScore;

// CHANGED
// The score for the right player
int rightScore;

// CHANGED
// The winning score
int winningScore = 3;

// CHANGED
// The floating-point number for the R value in RGB for the background color
float r;

// setup()
//
// Sets the size and creates the paddles and ball

void setup() {
  // CHANGED
  // Set the size
  size(700, 500);

  // CHANGED
  // Set the color mode to HSB (Hue Saturation Brightness)
  colorMode(HSB);

  // Create the paddles on either side of the screen. 
  // Use PADDLE_INSET to to position them on x, position them both at centre on y
  // Also pass through the two keys used to control 'up' and 'down' respectively
  // NOTE: On a mac you can run into trouble if you use keys that create that popup of
  // different accented characters in text editors (so avoid those if you're changing this)
  leftPaddle = new Paddle(PADDLE_INSET, height/2, '1', 'q');
  rightPaddle = new Paddle(width - PADDLE_INSET, height/2, '0', 'p');

  // Create the ball at the centre of the screen
  ball = new Ball(width/2, height/2);
}

// draw()
//
// Handles all the magic of making the paddles and ball move, checking
// if the ball has hit a paddle, and displaying everything.

void draw() {
  // CHANGED
  // Checks if the value in r is greater or equal to 255
  if (r >= 255) {
    // If it is, reset it to 0
    r = 0;
  } else {
    // If it is not, add 1 to its current value
    r++;
  }
  
  // CHANGED
  // Fill the background each frame so we have smooth transition animation of different background colors.
  // Calls the r variable with its value to plug in as the R value in RGB.
  background(r, 255, 255);

  // Update the paddles and ball by calling their update methods
  leftPaddle.update();
  rightPaddle.update();
  ball.update();

  // Check if the ball has collided with either paddle
  ball.collide(leftPaddle);
  ball.collide(rightPaddle);

  // Check if the ball has gone off the screen
  if (ball.isOffScreen()) {
    // If it has, reset the ball
    ball.reset();
  }

  // Display the paddles and the ball
  leftPaddle.display();
  rightPaddle.display();
  ball.display();

  // CHANGED
  // Display the scores
  displayScores();

  // CHANGED
  // Display winner and reset game
  whoWins();
}

// CHANGED
// displayScore()
//
// Displays the scores of the left and right players.

void displayScores() {
  // Loads a .vlw formatted font into a PFont object
  PFont font;
  font = loadFont("AmericanTypewriter-CondensedBold-48.vlw");
  // Set text color
  fill(255, 225, 0);
  // Horizontal alignment and vertical alignment will be centered
  textAlign(CENTER);
  // Set font family and size
  textFont(font, 60);
  // Set text for left player's score and location
  text(leftScore, (width/3), 70);
  // Set text for right player's score location
  text(rightScore, width - (width/3), 70);
}

// CHANGED
// whoWins()
//
// Checks if the left or right player wins.

void whoWins() {
  // Check if left score is equal to winning score
  if (leftScore == winningScore) {
    // If it is, display text "Left player wins!"
    displayGameOver("Left player wins!", color(255));

    // Set the ball's x and y velocity to 0
    ball.vx = 0;
    ball.vy = 0;

    // Set the x and y velocity of both paddles to 0
    leftPaddle.vx = 0;
    leftPaddle.vy = 0;
    rightPaddle.vx = 0;
    rightPaddle.vy = 0;

    // Check if the enter/return key is pressed
    if (keyCode == ENTER) {
      //  If it is, set both scores to 0
      leftScore = 0;
      rightScore = 0;

      // Set the ball's x and y velocity back to their default values
      ball.vx = ball.SPEED;
      ball.vy = ball.SPEED;
    }
  }

  // Check if right score is equal to winning score
  if (rightScore == winningScore) {
    // If it is, display text "Right player wins!"
    displayGameOver("Right player wins!", color(255));

    // Set the ball's velocity to 0
    ball.vx = 0;
    ball.vy = 0;

    // Set the x and y velocity of both paddles to 0
    leftPaddle.vx = 0;
    leftPaddle.vy = 0;
    rightPaddle.vx = 0;
    rightPaddle.vy = 0;

    // Check if the enter/return key is pressed
    if (keyCode == ENTER) {
      //  If it is, set both scores to 0
      leftScore = 0;
      rightScore = 0;

      // Set the ball's x and y velocity back to their default values
      ball.vx = ball.SPEED;
      ball.vy = ball.SPEED;
    }
  }
}

// CHANGED
// displayGameOver()
//
// Displays the game over text and the control key text to restart the game.

void displayGameOver(String whoWinsText, color whoWinsColor) {
  // Set text color for "GAME OVER"
  fill(255, 0, 0);
  // Set text and location
  text("GAME OVER", width/2, height/2);
  // Set text color for whoWinsText
  fill(whoWinsColor);
  // Set text of player who wins and location
  text(whoWinsText, width/2, (height/2 + 60));
  // Set text size for control key text
  textSize(30);
  // Set text and location
  text("Press ENTER to restart.", width/2, (height/2 + 120));
}


// keyPressed()
//
// The paddles need to know if they should move based on a keypress
// so when the keypress is detected in the main program we need to
// tell the paddles

void keyPressed() {
  // Just call both paddles' own keyPressed methods
  leftPaddle.keyPressed();
  rightPaddle.keyPressed();
}

// keyReleased()
//
// As for keyPressed, except for released!

void keyReleased() {
  // Call both paddles' keyReleased methods
  leftPaddle.keyReleased();
  rightPaddle.keyReleased();
}