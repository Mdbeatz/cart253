// creates the background colour
color backgroundColor = color(255,204,153); // CHANGED background colour

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
color paddleColor = color(255);

int ballX;
int ballY;
int ballVX;
int ballVY;
// assigns the velocity for the ball
int ballSpeed = 5;
// assigns the diameter for the ball
int ballSize = 16;
// assigns colour for the ball
color ballColor = color(255);

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
// 
void setupPaddle() {
  paddleX = width/2;
  paddleY = height - paddleHeight;
  paddleVX = 0;
}

// setupBall()
//
//
void setupBall() {
  ballX = width/2;
  ballY = height/2;
  ballVX = ballSpeed;
  ballVY = ballSpeed;
}

// draw()
//
//
void draw() {
  background(backgroundColor);

  drawStatic();

  updatePaddle();
  updateBall();

  drawPaddle();
  drawBall();
}

// drawStatic()
//
//
void drawStatic() {
  for (int i = 0; i < numStatic; i++) {
    float x = random(0, width);
    float y = random(0, height);
    float staticSize = random(staticSizeMin, staticSizeMax);
    fill(staticColor);
    rect(x, y, staticSize, staticSize);
  }
}

// updatePaddle()
//
//
void updatePaddle() {
  paddleX += paddleVX;  
  paddleX = constrain(paddleX, 0+paddleWidth/2, width-paddleWidth/2);
}

// updateBall()
//
//
void updateBall() {
  ballX += ballVX;
  ballY += ballVY;

  handleBallHitPaddle();
  handleBallHitWall();
  handleBallOffBottom();
}

// drawPaddle()
//
//
void drawPaddle() {
  rectMode(CENTER);
  noStroke();
  fill(paddleColor);
  rect(paddleX, paddleY, paddleWidth, paddleHeight);
}

void drawBall() {
  rectMode(CENTER);
  noStroke();
  fill(ballColor);
  rect(ballX, ballY, ballSize, ballSize);
}

void handleBallHitPaddle() {
  if (ballOverlapsPaddle()) {
    ballY = paddleY - paddleHeight/2 - ballSize/2;
    ballVY = -ballVY;
  }
}

boolean ballOverlapsPaddle() {
  if (ballX - ballSize/2 > paddleX - paddleWidth/2 && ballX + ballSize/2 < paddleX + paddleWidth/2) {
    if (ballY > paddleY - paddleHeight/2) {
      return true;
    }
  }
  return false;
}

void handleBallOffBottom() {
  if (ballOffBottom()) {
    ballX = width/2;
    ballY = height/2;
  }
}

boolean ballOffBottom() {
  return (ballY - ballSize/2 > height);
}

void handleBallHitWall() {
  if (ballX - ballSize/2 < 0) {
    ballX = 0 + ballSize/2;
    ballVX = -ballVX;
  } else if (ballX + ballSize/2 > width) {
    ballX = width - ballSize/2;
    ballVX = -ballVX;
  }

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