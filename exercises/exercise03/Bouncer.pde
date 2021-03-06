class Bouncer {

  /////////////// Properties ///////////////

  // The location of the ball
  int x;
  int y;

  // The velocity of the ball
  int vx;
  int vy;

  // The size of the ball
  int size;

  // CHANGED
  // The default size of the ball
  int defaultSize;

  // CHANGED
  // The new size of the ball once clicked on
  int newSize = 70;

  // The fill color of the ball
  color fillColor;

  // The default fill color of the ball
  color defaultColor;

  // The hover color of the ball
  color hoverColor;

  // CHANGED
  // The temp fill color of the bouncer when the mouse is being pressed
  color tempMouseClickedFillColor;

  // CHANGED
  // The fill color of the bouncer when the mouse is being pressed.
  color mouseClickedFillColor;


  /////////////// Constructor ///////////////

  // Bouncer(int tempX, int tempY, int tempVX, int tempVY, int tempSize, color tempDefaultColor, color tempHoverColor)
  //
  // Sets the variables to their starting values.
  // x, y, vx, vy, size, fillColor and hoverColor are set to the arguments passed through from the main program (exercise03).
  Bouncer(int tempX, int tempY, int tempVX, int tempVY, int tempSize, color tempDefaultColor, color tempHoverColor, color tempMouseClickedFillColor) {
    // Set x to new temp y value
    x = tempX;

    // Set y to new temp y value
    y = tempY;

    // Set vx to new temp x velocity value
    vx = tempVX;

    // Set vy to new temp y velocity value
    vy = tempVY;

    // CHANGED
    // Set size to new temp size value
    defaultSize = tempSize;

    // CHANGED
    // Set the size back to the default size value
    size = defaultSize;

    // Set default color to new temp default color value
    defaultColor = tempDefaultColor;

    // Set hover color to new temp hover color value
    hoverColor = tempHoverColor;

    // Set fill color to default color value
    fillColor = defaultColor;

    // CHANGED
    // Set the fill color of the ball when the mouse is being pressed to the temp fill color of the ball when the mouse is being pressed
    mouseClickedFillColor = tempMouseClickedFillColor;
  }


  /////////////// Methods ///////////////

  // update()
  //
  // Moves the bouncing balls each frame.
  // Handles the wall collisions by calling handleBounce() and mouse position by calling handleMouse().
  void update() {
    // Move the bouncing ball each frame by adding its velocity each frame
    x += vx;
    y += vy;

    // Make the ball bounce off the walls
    handleBounce();

    // Make the ball's fill color change if the mouse is over the ball
    handleMouse();
  }

  // handleBounce()
  //
  // Checks if the ball is colliding with the walls.
  // If it is, it makes the ball bounce away from the walls by reversing its vx and vy velocities.
  void handleBounce() {
    // Check if the ball is colliding with the left or right walls
    if (x - size/2 < 0 || x + size/2 > width) {
      // If it is, make it bounce by reversing its vx velocity
      vx = -vx;

      // CHANGED
      // Teleport the bouncer's x coordinate to a random location
      x = (int) random(width);
    }

    // Check if the ball is colliding with the top or bottom walls
    if (y - size/2 < 0 || y + size/2 > height) {
      // If it is, make it bounce by reversing its vy velocity
      vy = -vy;

      // CHANGED
      // Teleport the bouncer's y coordinate to a random location
      y = (int) random(height);
    }

    // Constrain bouncer to window
    x = constrain(x, size/2, width-size/2);
    y = constrain(y, size/2, height-size/2);
  }

  // handleMouse()
  //
  // Checks if the mouse cursor is hovering over the ball.
  // If it is, then the fill color of the ball will change.
  void handleMouse() {
    // CHANGED
    // Check if the distance of the cursor location is less than the size of the ball.
    if (dist(mouseX, mouseY, x, y) < size) {
      // If it is, then make the fill color change to the hover color.
      fillColor = hoverColor;
    } else {
      // If it is not, then the fill color returns to the default color.
      fillColor = defaultColor;
    }
  }

  // CHANGED
  // mouseClicked()
  //
  // Checks if the mouse is clicked on a ball.
  void mouseClicked() {
    // Check if the distance of the cursor location is less than the size of the ball.
    if (dist(mouseX, mouseY, x, y) < size) {
      // If it is, then make the size the new bigger size.
      size = newSize;
      // It will also change the fill color to its new temp fill color.
      defaultColor = mouseClickedFillColor;
    } 
  }

  // draw()
  //
  // Creates the circle for the ball.
  void draw() {
    // No stroke around the circle
    noStroke();

    // Set the fill color of the circle
    fill(fillColor);

    // Set the center X and Y coordinates of the circle, and the width and height of the circle
    ellipse(x, y, size, size);
  }
}