// Exercise08
//
// PREPARED BY: Marianne De Bonis
//
//


// Array storing all the stars for the starfield
Starfield[] starfieldBackground = new Starfield[300];

// Global variable for the superhero
Superhero superhero;

// Space between Superhero and the bottom of the window
int superheroInset = 170;

color backgroundColor = color (8, 5, 45);

// setup()
//
// Sets the size and creates the Superhero
void setup() {
  size(640, 900);

  // Create the amount of stars that are stored in the starfield background array
  for (int i = 0; i < starfieldBackground.length; i++) {
    int x = floor(random(width));
    int y = floor(random(height));
    int vy = floor(random(1, 3));
    int size = floor(random(1, 4));

    starfieldBackground[i] = new Starfield(x, y, vy, size);
  }  

  superhero = new Superhero(width/2, height - superheroInset);
}

// draw()
//
// Handles all the magic of making the Superhero move.
void draw() {
  background(backgroundColor);  
  displayStarfieldBackground();

  displayPlanet();

  superhero.update();
  superhero.display();
}

// displayStarfieldBackground()
//
// Display the starfield background.
void displayStarfieldBackground() {
  // Loop through all the stars one by one
  for (int i = 0; i < starfieldBackground.length; i++) {
    // Update the starfield background
    starfieldBackground[i].update();

    // Display the starfield background
    starfieldBackground[i].display();
  }
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