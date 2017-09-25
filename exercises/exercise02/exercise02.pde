// creates the background colour
color backgroundColor = color(255, 204, 153); // CHANGED background colour

// assigns the pixels for the static
int numStatic = 200; // CHANGED the value
// assigns the minimum size for the static pixels
int staticSizeMin = 1;
// assigns the maximum size for the static pixels
int staticSizeMax = 3;
color staticColor = color(255);

int paddleX;
int paddleY;
int paddleVX;
// assigns the velocity for the paddle
int paddleSpeed = 10;
// assigns the width for the paddle
int paddleWidth = 128;
// assigns the height for the paddle
int paddleHeight = 16;
// assigns the colour for the paddle
color paddleColor = color(0); // CHANGED colour

int ballX;
int ballY;
int ballVX;
int ballVY;
// assigns the velocity for the ball
int ballSpeed = 5;
// assigns the diameter for the ball
int ballSize = 16;
// assigns colour for the ball
color ballColor = color(0); // CHANGED colour

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
// calls the drawStatic(), updatePaddle(), updateBall(), drawPaddle() and drawBall() functions
void draw() {
  background(backgroundColor);
  
  drawStatic();

  updatePaddle();
  updateBall();

  drawPaddle();
  drawBall();
  
  // Loads a .vlw formatted font into a PFont object
  PFont font;
  font = loadFont("AmericanTypewriter-CondensedBold-48.vlw");
  textFont(font, 60);
  textAlign(CENTER);
  text("PONG",width/2,height/5);
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
    
    while (ballColor == backgroundColor) {
      ballColor = color (random(255), random(255), random(255));
    }
    
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
    
    //backgroundColor = color(0);
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