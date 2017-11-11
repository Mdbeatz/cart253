// Final Project
//
// PREPARED BY: Marianne De Bonis

// Global variable for the superhero
Marine marine;

// setup()
//
// Sets the size and creates the superhero Marine
void setup() {
  size(640, 800);

  marine = new Marine(width/2, height-50);
}

// draw()
//
// Handles all the magic of making the superhero, Marine, move.
void draw() {
  background(8, 5, 45);

  marine.update();
  marine.display();
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