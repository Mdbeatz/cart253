// Exercise07
// 
// PREPARED BY: Marianne De Bonis
//
//

// Import the sound library
import processing.sound.*;

// Sound file objects
SoundFile tone01;
SoundFile tone02;
SoundFile tone03;

// Array storing all the bubbles
Bubble[] bubbles = new Bubble[20];

// Background color
color backgroundColor = color(0, 26, 51);

// setup()
//
//
void setup() {
  size(400, 600);

  tone01 = new SoundFile(this, "sounds/tone01.wav");
  tone02 = new SoundFile(this, "sounds/tone03.wav");
  tone03 = new SoundFile(this, "sounds/tone05.wav");

  // Create the amount of bubbles that are stored in the array
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

  // Loop through all the bubbles one by one
  for (int i = 0; i < bubbles.length; i++) {
    // Update the bubbles
    bubbles[i].update();

    // Display the bubbles
    bubbles[i].display();

    // Play sounds
    bubbles[i].playSound();
  }
}