// Exercise08
//
// PREPARED BY: Marianne De Bonis
//
//


// Global variable for the superhero
Superhero superhero;

// Space between Superhero and the bottom of the window
int superheroInset = 170;

// setup()
//
// Sets the size and creates the Superhero
void setup() {
  size(640, 800);

  superhero = new Superhero(width/2, height - superheroInset);
}

// draw()
//
// Handles all the magic of making the Superhero move.
void draw() {
  background(8, 5, 45);

  displayPlanet();

  superhero.update();
  superhero.display();
}

// displayPlanet()
//
// Creates the Superhero's planet.
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
  superhero.keyPressed();
}

// keyReleased()
//
// Same as KeyPressed, except for released.
void keyReleased() {
  superhero.keyReleased();
}