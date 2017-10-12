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

// CHANGED
int numStatic = 700; 
int staticSizeMin = 1; 
int staticSizeMax = 2; 
color staticColor = color(255);

boolean gameOver = false;

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
int winningScore = 5;

// CHANGED
// The floating-point number for the R value in RGB for the background color
float r;

// CHANGED
// Global font variable
PFont font;

// CHANGED
// Horizontal location for the scrolling text
float x;

// CHANGED
// index for scrollingText array
int index = 0;

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

  // CHANGED
  // Set scrollingText's x location offscreen
  x = width;

  // CHANGED
  //
  // Create the paddles on either side of the screen. 
  // Use PADDLE_INSET to to position them on x, position them both at centre on y
  // Also pass through the two keys used to control 'up' and 'down' respectively
  // NOTE: On a mac you can run into trouble if you use keys that create that popup of
  // different accented characters in text editors (so avoid those if you're changing this)
  leftPaddle = new Paddle(PADDLE_INSET + 20, height/2, '1', 'q');
  rightPaddle = new Paddle((width - PADDLE_INSET) - 20, height/2, '0', 'p');

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

  // CHANGED
  // Fill the background each frame with static pixels.
  drawStatic();

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
  // Display the winner and reset the game
  whoWins();

  // CHANGED
  // Display the scrolling text when the users are playing.
  // The scrolling text will not display if the game over text is prompted.
  if (!gameOver) {
    displayScrollingText();
  }
}

// CHANGED
// drawStatic()
//
// Creates an infinite loop for the static background effect
void drawStatic() {
  for (int i = 0; i < numStatic; i++) {
    float x = random(0, width); // creates a random value between 0 and the width of the window for x
    float y = random(0, height); // creates a random value between 0 and the height of the window for y
    float staticSize = random(staticSizeMin, staticSizeMax); // creates random sized static pixels between sizes 1 and 3
    fill(staticColor); // calls the colour   
    rect(x, y, staticSize, staticSize); // positions the static pixels randomly within the window
  }
}

// CHANGED
// displayScore()
//
// Displays the scores of the both players.

void displayScores() {
  // Loads a .vlw formatted font into a PFont object
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

    // Set the gameOver to true so the scrolling text will not appear
    gameOver = true;

    // The function called to reset the window/game
    resets();
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

    // Set the gameOver to true so the scrolling text will not appear
    gameOver = true;

    // The function called to reset the window/game
    resets();
  }
}

// CHANGED
// resets()
//
// Function to reset values.

void resets() {
  // Check if the shift key is pressed
  if (keyPressed && keyCode == SHIFT) {
    // Set both scores to 0
    leftScore = 0;
    rightScore = 0;

    // Set the ball's x and y velocity back to their default values
    ball.vx = ball.SPEED;
    ball.vy = ball.SPEED;

    // Set the paddle heights back to their default heights
    leftPaddle.HEIGHT = leftPaddle.defaultHEIGHT;
    rightPaddle.HEIGHT = rightPaddle.defaultHEIGHT;

    // Decrement x by 3
    // The scrolling text will start off the window again, and will come scrolling in again
    x = width - 3;

    // Reset the index for the scrolling text array to 0
    // This makes the array start from the first sentences again
    index = 0;

    // Set the gameOver to false so the scrolling text will appear
    gameOver = false;

    // Reset the ball's speed to the new speed of 6
    ball.vx = ball.newSPEED;
    ball.vy = ball.newSPEED;
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
  text("GAME OVER", width/2, height/3);
  // Set text color for whoWinsText
  fill(whoWinsColor);
  // Set text of player who wins and location
  text(whoWinsText, width/2, (height/2 + 80));
  // Set text size for control key text
  textSize(30);
  // Set text and location
  text("Press SHIFT to restart.", width/2, (height/2 + 140));
}

// CHANGED
// displayScrollingText()
//
// Displays the scrolling text.

void displayScrollingText() {

  // An array of text
  String[] scrollingText = {
    "PEEK-A-BOO! Reach 5 to win.", 
    "KEEP CALM AND PLAY PONG!"
  };

  // Checks if either score is greater or equal to 1.
  // If it is, it will display the scrolling text
  if (leftScore >= 1 || rightScore >= 1) {
    // Set the font family and font size
    textFont(font, 50);
    // Align the text to the left
    textAlign(LEFT);
    // Display a string from the array based on the index value
    text(scrollingText[index], x, height - 30);

    // Decrement x by 3
    x = x - 3;

    // Calculate the width of the current string
    float scrollingTextWidth = textWidth(scrollingText[index]);

    // Checks if x is less than the negative width.
    // If it is, then that means it is off the screen.
    if (x < -scrollingTextWidth) {
      // Set x back to the width again
      x = width;

      // Increment index by 1 when the current string has left the window and display the next string.
      index = (index + 1) % scrollingText.length;
    }
  }
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