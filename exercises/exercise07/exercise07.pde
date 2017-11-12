// Exercise07
// 
// PREPARED BY: Marianne De Bonis
//
//

// Import the sound library
import processing.sound.*;

// Array storing all the bubbles
Bubble[] bubbles = new Bubble[40];

// Background color
color backgroundColor = color(0, 26, 51);

// setup()
//
//
void setup() {
  size(400, 600);

  for (int i = 0; i < bubbles.length; i++) {
    int x = floor(random(width));
    int y = floor(random(height));
    int vy = floor(random(3, 7));
    int size = floor(random(30, 50));
    
    bubbles[i] = new Bubble(x, y, vy, size);
  }
}

// draw()
//
//
void draw() {
  background(backgroundColor);

  for (int i = 0; i < bubbles.length; i++) {
    bubbles[i].update();
    bubbles[i].display();
  }
}