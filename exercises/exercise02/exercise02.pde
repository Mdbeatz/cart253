// CHANGED background colours
color backgroundColor1 = color(255, 204, 153); // peach orange
color backgroundColor2 = color(255, 153, 204); // bubblegum pink
color backgroundColor3 = color(153, 204, 255); // sky blue 
color backgroundColor4 = color(153, 255, 204); // pale green

int numStatic = 200; // CHANGED the value, assigns the pixels for the static
int staticSizeMin = 1; // assigns the minimum size for the static pixels
int staticSizeMax = 4; // CHANGED. assigns the maximum size for the static pixels
color staticColor = color(255); // CHANGED

int paddleX; // paddle's x location
int paddleY; // paddle's y location
int paddleVX; // paddle's x velocity
int paddleSpeed = 10; // assigns the velocity for the paddle
int paddleDefaultWidth = 130; // CHANGED. assigns the default width
int paddleWidth = paddleDefaultWidth; // CHANGED. assigns the default width to paddleWidth
int paddleHeight = 16; // assigns the height for the paddle
color paddleColor = color(0); // CHANGED colour. assigns the colour for the paddle

int ballX; // ball's x location
int ballY; // ball's y location
int ballVX; // ball's x velocity
int ballVY; // ball's y velocity
int ballSpeed = 7; // CHANGED value of the ball velocity. assigns the velocity for the ball
int ballSize = 16; // assigns the diameter for the ball
color ballColor = color(0); // CHANGED colour. assigns colour for the ball

// CHANGED
int score = 0; // the score, starts with 0
int winningScore = 10; // the winning score
int losingScore = -5; // the losing score

// setup()
//
// sets the size of the window
// calls the setupPaddle() and setupBall() functions
void setup() {
  size(640, 480); // size of the window

  setupPaddle();
  setupBall();
}

// setupPaddle()
//
// the paddle will start off in the bottom center of the window
// the velocity of the paddle will start off at 0
void setupPaddle() {
  paddleX = width/2; 
  paddleY = height - paddleHeight;  
  paddleVX = 0;
}

// setupBall()
//
// the ball will spawn in the center of the window
// the velocity is called for both the X and Y axis
void setupBall() {
  ballX = width/2; 
  ballY = height/2;
  ballVX = ballSpeed;
  ballVY = ballSpeed;
}

// draw()
//
// calls the backgroundColor variable
// calls the drawStatic(), updatePaddle(), updateBall(), drawPaddle(), drawBall(), displayScore() and gameOver() functions
void draw() {
  changeBackgroundColor();  

  drawStatic();

  updatePaddle();
  updateBall();

  drawPaddle();
  drawBall();

  // CHANGED
  displayScore();
  gameOver();
}

// CHANGED
// changeBackgroundColor()
//
// Background color changes based on the X and Y coordinates of the ball's center
void changeBackgroundColor() {
  if (ballX < (width/2) && ballY < (height/2)) { // upper left, peach orange
    background(backgroundColor1);
  } else if (ballX > (width/2) && ballY < (height/2)) { // upper right, bubblegum pink
    background(backgroundColor2);
  } else if (ballX < (width/2) && ballY > (height/2)) { // bottom left, sky blue
    background(backgroundColor3);
  } else if (ballX > (width/2) && ballY > (height/2)) { // bottom right, pale green
    background(backgroundColor4);
  }
}

// drawStatic()
//
// creates an infinite loop for the static background effect
void drawStatic() {
  for (int i = 0; i < numStatic; i++) {
    float x = random(0, width); // creates a random value between 0 and the width of the window for x
    float y = random(0, height); // creates a random value between 0 and the height of the window for y
    float staticSize = random(staticSizeMin, staticSizeMax); // creates random sized static pixels between sizes 1 and 3
    fill(staticColor); // calls the colour   
    rect(x, y, staticSize, staticSize); // positions the static pixels randomly within the window
  }
}

// updatePaddle()
//
// allows the paddle to move within the window
void updatePaddle() {
  paddleX += paddleVX; // moves paddle
  paddleX = constrain(paddleX, 0 + paddleWidth/2, width - paddleWidth/2); // window constraints
}

// updateBall()
//
// moves the ball.
// calls the handleBallHitPaddle(), handleBallHitWall() and handleBallOffBottom() functions
void updateBall() {
  // moves the ball
  ballX += ballVX;
  ballY += ballVY;

  handleBallHitPaddle();
  handleBallHitWall();
  handleBallOffBottom();
}

// drawPaddle()
//
// creates the paddle
void drawPaddle() {
  rectMode(CENTER); // allows paddleX and paddleY to be the center point
  noStroke();
  fill(paddleColor);
  rect(paddleX, paddleY, paddleWidth, paddleHeight);
}

// drawBall()
//
// creates the ball
void drawBall() {
  ellipseMode(CENTER); // allows ballX and ballY to be the center point
  noStroke();
  fill(ballColor);
  ellipse(ballX, ballY, ballSize, ballSize);  // CHANGED the shape of the ball from rect to ellipse
}

// handleBallHitPaddle()
//
// function is called when ballOverlapsPaddle() returns TRUE
// when TRUE, the ball will bounce off the paddle in a negative velocity going upwards
void handleBallHitPaddle() {
  if (ballOverlapsPaddle()) {
    // CHANGED 
    // the fill of the ball will be a random colour when it bounces off the paddle
    ballColor = color (random(255), random(255), random(255));

    // CHANGED
    // making sure the random ball color never gets assigned the same RGB values as the background colors
    while (ballColor == backgroundColor1 || ballColor == backgroundColor2 || ballColor == backgroundColor3 || ballColor == backgroundColor4) {
      ballColor = color (random(255), random(255), random(255));
    }

    // CHANGED
    // adds 1 to the score value
    score++;

    // when TRUE, the ball will bounce off the paddle in a negative velocity going upwards
    ballY = paddleY - paddleHeight/2 - ballSize/2;
    ballVY = -ballVY;
  }
}

// ballOverlapsPaddle()
//
// if the ball hits the paddle, function will return TRUE
// if the ball does NOT hit the paddle, function will return FALSE
boolean ballOverlapsPaddle() {
  if (ballX - ballSize/2 > paddleX - paddleWidth/2 && ballX + ballSize/2 < paddleX + paddleWidth/2) {
    if (ballY > paddleY - paddleHeight/2) {
      //println("hit paddle"); // testing for my own purposes
      return true;
    }
  }
  return false;
}

// CHANGED 
// randomSpawn()
//
// the random location of where the ball will spawn
// the ball will now spawn at any random X and Y coordinate within the window
void randomSpawn() {
  ballX = (int)random(width);
  ballY = (int)random(height - 50);
}

// handleBallOffBottom()
//
// if the ball exits the window the ball gets spawned in the center of the window, 
// the score is affected, and the size of the paddle decreases.
void handleBallOffBottom() {
  if (ballOffBottom()) {
    // spawns in random locations
    randomSpawn();

    // CHANGED
    // subtracts the score value by 1
    score--;

    // the paddle will decrease by 15 pixels, as long as the paddle width is more or equal to 50 pixels
    if (paddleWidth > 50) {
      paddleWidth = paddleWidth - 15;
    }
  }
}

// ballOffBottom()
//
// checking if the bottom of the ball is more than the height of the window
// essentially checking if the ball exits the window by the bottom
boolean ballOffBottom() {
  return (ballY - ballSize/2 > height);
}

// handleBallHitWall()
//
// makes sure the ball does not go off screen
void handleBallHitWall() {
  // if the ball hits the left border of the window it will bounce off
  if (ballX - ballSize/2 < 0) {
    ballX = 0 + ballSize/2;
    ballVX = -ballVX;
  } else if (ballX + ballSize/2 > width) { // if the ball hits the right border of the window it will bounce off
    ballX = width - ballSize/2;
    ballVX = -ballVX;
  }

  // if the ball hits the top border of the window it will bounce off
  if (ballY - ballSize/2 < 0) {
    ballY = 0 + ballSize/2;
    ballVY = -ballVY;
  }
}

// CHANGED
// displayScore()
//
// Displays the title and the score
void displayScore() {
  // Loads a .vlw formatted font into a PFont object
  PFont font;
  font = loadFont("AmericanTypewriter-CondensedBold-48.vlw");
  textFont(font, 60); // sets which font is chosen and the size
  textAlign(CENTER); // horizontal alignment and vertical alignment will be centered
  text("PONG", width/2, height/5); // text and locations
  textFont(font, 30); // sets which font is chosen and the size
  text("SCORE: " + score, width/2, height/3); // text and locations
}

// CHANGED
// gameOver()
//
// Handles what will happen if the user wins or loses
void gameOver() {
  if (score == winningScore) {
    displayGameOver("YOU WIN!", color(255));

    // the ball's velocity will increase by 1 if the user wins
    if (mousePressed || (keyCode == ENTER)) {
      // score will reset
      score = 0;

      // velocity increases by 1
      ballSpeed++;

      // spawns in random locations
      randomSpawn();

      ballVX = ballSpeed;
      ballVY = ballSpeed;

      // freezes the paddle
      paddleVX = 0;
      
      // width of paddle goes back to the default width of 130 pixels
      paddleWidth = paddleDefaultWidth;
    }
  }

  // the ball's velocity will remain the same if the user loses
  if (score == losingScore) {
    displayGameOver("YOU LOSE!", color(255));

    if (mousePressed || (keyCode == ENTER)) {
      // score will reset
      score = 0;

      // spawns in random locations
      randomSpawn();

      ballVX = ballSpeed;
      ballVY = ballSpeed;

      // freezes the paddle
      paddleVX = 0;

      // width of paddle goes back to the default width of 130 pixels
      paddleWidth = paddleDefaultWidth;
    }
  }
}

// CHANGED
// displayGameOver()
//
// Displays the text and freezes the ball and paddle
void displayGameOver(String text, color c) {
  // freezes the ball and paddle by resetting their velocities back to 0
  paddleVX = 0;
  ballVX = 0;
  ballVY = 0;

  text("GAME OVER", width/2, height/2); // text and locations
  fill(c); // accepts the text color from the function above, which is 255 (white)
  text(text, width/2, (height/2 + 30)); // text and locations
  text("Click or Press Enter", width/2, (height/2 + 60)); // text and locations
}

// keyPressed()
//
// if the left arrow key is pressed the paddle will have a negative velocity making it go left/backwards
// if the right arrow key is pressed the paddle will have a positive velocity making it to right/forward
void keyPressed() {
  if (keyCode == LEFT) {
    paddleVX = -paddleSpeed;
  } else if (keyCode == RIGHT) {
    paddleVX = paddleSpeed;
  }
}

// keyReleased()
//
// if the left arrow key is released AND its velocity is less than 0, the paddle will not move/remain in its location
// if the right arrow key is released AND its velocity is less than 0, the paddle will not move/remain in its location
void keyReleased() {
  if (keyCode == LEFT && paddleVX < 0) {
    paddleVX = 0;
  } else if (keyCode == RIGHT && paddleVX > 0) {
    paddleVX = 0;
  }
}