// Final Project
//
// PREPARED BY: Marianne De Bonis

// Global variable for the superhero
Marine marine;

// Space between Marine and the bottom of the window
int marineInset = 170;

// setup()
//
// Sets the size and creates the superhero Marine
void setup() {
  size(640, 800);

  marine = new Marine(width/2, height - marineInset);
}

// draw()
//
// Handles all the magic of making the superhero, Marine, move.
void draw() {
  background(8, 5, 45);

  displayPlanet();

  marine.update();
  marine.display();
}

// displayPlanet()
//
// Creates Marine's planet.
void displayPlanet() {
  noStroke();
  fill(238, 174, 121);
  ellipse(width/2, height + 375, 1000, 1000);
}

// keyPressed()
//
// The superhero needs to know if it should move based on keypress,
// so when the keypress is detected in the main program we need to tell the superhero.
void keyPressed() {
  marine.keyPressed();
}

// keyReleased()
//
// Same as KeyPressed, except for released.
void keyReleased() {
  marine.keyReleased();
}