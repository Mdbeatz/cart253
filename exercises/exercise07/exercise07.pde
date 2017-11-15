// Exercise07 - Sound
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
SoundFile kickSound;
SoundFile snareSound;

// Array storing all the bubbles
Bubble[] bubbles = new Bubble[30];

// Array storing all the griddies
Griddie[] griddies = new Griddie[100];

// Counter for the griddies appearing on screen
int griddiesCounter = 0;

// Background color
color backgroundColor = color(0, 26, 51);

// setup()
//
// 
void setup() {
  size(500, 600);

  // Create the sound files
  tone01 = new SoundFile(this, "sounds/tone01.wav");
  tone02 = new SoundFile(this, "sounds/tone03.wav");
  tone03 = new SoundFile(this, "sounds/tone05.wav");
  kickSound = new SoundFile(this, "sounds/kick.wav");
  snareSound = new SoundFile(this, "sounds/snare.wav");

  // Create the amount of bubbles that are stored in the array
  for (int i = 0; i < bubbles.length; i++) {
    int x = floor(random(width));
    int y = floor(random(height));
    int vy = floor(random(3, 7));
    int size = floor(random(30, 50));

    bubbles[i] = new Bubble(x, y, vy, size);
  }

  // Create the amount of griddies that are stored in the array
  for (int i = 0; i < griddies.length; i++) {
    int x = floor(random(width));
    int y = floor(random(height));
    int vx = floor(random(2, 5));
    int size = floor(random(30, 50));

    griddies[i] = new Griddie(x, y, vx, size);
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

  // Loop through the griddiesCounter
  for (int i = 0; i < griddiesCounter; i++) {
    // Update the bubbles
    griddies[i].update();

    // Display the bubbles
    griddies[i].display();
  }
}

// void keyPressed()
//
//
void keyPressed() {

  griddiesCounter++;

  if (griddiesCounter == griddies.length) {
    griddiesCounter = griddies.length-1;
  } else {
    griddies[griddiesCounter].playSound();
  }

}