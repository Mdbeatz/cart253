// background colours
color backgroundColor1 = color(255, 204, 153); // peach orange
color backgroundColor2 = color(255, 153, 204); // bubblegum pink
color backgroundColor3 = color(153, 204, 255); // sky blue 
color backgroundColor4 = color(153, 255, 204); // pale green

int numStatic = 200; // CHANGED the value, assigns the pixels for the static
int staticSizeMin = 1; // assigns the minimum size for the static pixels
int staticSizeMax = 3; // assigns the maximum size for the static pixels
color staticColor = color(255);

int paddleX;
int paddleY;
int paddleVX;

int paddleSpeed = 10; // assigns the velocity for the paddle
int paddleWidth = 128; // assigns the width for the paddle
int paddleHeight = 16; // assigns the height for the paddle
color paddleColor = color(0); // CHANGED colour. assigns the colour for the paddle

int ballX;
int ballY;
int ballVX;
int ballVY;
int ballSpeed = 6; // CHANGEd value of the ball velocity. assigns the velocity for the ball
int ballSize = 16; // assigns the diameter for the ball
color ballColor = color(0); // CHANGED colour. assigns colour for the ball

int score = 0;
int winningScore = 10;
int losingScore = -10;

// setup()
//
// sets the size of the window
// calls the setupPaddle() and setupBall() functions
void setup() {
  size(640, 480);

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
// calls the drawStatic(), updatePaddle(), updateBall(), drawPaddle(), drawBall() and displayScore() functions
void draw() {
  changeBackgroundColor(); // CHANGED 

  drawStatic();

  updatePaddle();
  updateBall();

  drawPaddle();
  drawBall();

  displayScore();
  gameOver();
}

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
    // creates a random value between 0 and the width of the window for x
    float x = random(0, width);
    
    // creates a random value between 0 and the height of the window for y
    float y = random(0, height);
    
    // creates random sized static pixels between sizes 1 and 3
    float staticSize = random(staticSizeMin, staticSizeMax);
    
    // calls the colour
    fill(staticColor);
    
    // positions the static pixels randomly within the window
    rect(x, y, staticSize, staticSize);
  }
}

// updatePaddle()
//
// 
void updatePaddle() {
  paddleX += paddleVX;  
  paddleX = constrain(paddleX, 0 + paddleWidth/2, width - paddleWidth/2);
}

// updateBall()
//
// calls the handleBallHitPaddle(), handleBallHitWall() and handleBallOffBottom() functions
void updateBall() {
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
  // allows paddleX and paddleY to be the center point
  rectMode(CENTER);
  noStroke();
  fill(paddleColor);
  rect(paddleX, paddleY, paddleWidth, paddleHeight);
}

// drawBall()
//
// creates the ball
void drawBall() {
  // allows ballX and ballY to be the center point
  ellipseMode(CENTER);
  noStroke();
  fill(ballColor);
  // CHANGED the shape of the ball from rect to ellipse
  ellipse(ballX, ballY, ballSize, ballSize);
}

// handleBallHitPaddle()
//
// function is called when ballOverlapsPaddle() returns TRUE
// when TRUE, the ball will bounce off the paddle in a negative velocity going upwards
void handleBallHitPaddle() {
  if (ballOverlapsPaddle()) {
    // CHANGED the fill of the ball to a random colour when it bounces off the paddle
    ballColor = color (random(255), random(255), random(255));
    
    // making sure the random ball color never gets assigned the same RGB values as the background colors
    while (ballColor == backgroundColor1 || ballColor == backgroundColor2 || ballColor == backgroundColor3 || ballColor == backgroundColor4) {
      ballColor = color (random(255), random(255), random(255));
    }

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

// handleBallOffBottom()
//
// if the ball exits the window the ball gets spawned in the center of the window
void handleBallOffBottom() {
  if (ballOffBottom()) {
    //ballX = width/2;
    //ballY = height/2;

    // CHANGED the location of where the ball will spawn
    // the ball will now spawn at any random X and Y coordinate within the window
    ballX = (int)random(width);
    ballY = (int)random(height);

    // subtracts the score value by 1
    score--;
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

// displayScore()
//
//
void displayScore() {
  // Loads a .vlw formatted font into a PFont object
  PFont font;
  font = loadFont("AmericanTypewriter-CondensedBold-48.vlw");
  textFont(font, 60);
  textAlign(CENTER);
  text("PONG", width/2, height/5);
  textFont(font, 30);
  text("SCORE: " + score, width/2, height/3);
}

// gameOver()
//
//
void gameOver() {
  if (score == winningScore) {
    displayGameOver("YOU WIN!", color(255));
    
    // the ball's velocity will increase if the user wins
    if (mousePressed || (keyCode == ENTER)) {
      score = 0;

      ballSpeed = 10;

      ballVX = ballSpeed;
      ballVY = ballSpeed;
    }
  }
  
  // the ball's velocity will remain the same if the user loses
  if (score == losingScore) {
    displayGameOver("YOU LOSE!", color(255));

    if (mousePressed || (keyCode == ENTER)) {
      score = 0;
      
      ballVX = ballSpeed;
      ballVY = ballSpeed;
    }
  }
}

// displayGameOver
//
//
void displayGameOver(String text, color c) {
  paddleVX = 0;
  ballVX = 0;
  ballVY = 0;

  text("GAME OVER", width/2, height/2);
  fill(c);
  text(text, width/2, (height/2 + 30));
  text("Click or Press Enter", width/2, (height/2 + 60));

  //if (mousePressed || (keyCode == ENTER)) {
  //  score = 0;

  //  ballSpeed = 10;

  //  ballVX = ballSpeed;
  //  ballVY = ballSpeed;
  //}
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