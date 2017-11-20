// Exercise08
// Final Project Prototype
//
// PREPARED BY: Marianne De Bonis
//
//


// Array storing all the stars for the starfield
Starfield[] starfieldBackground = new Starfield[300];

// Global variable for the superhero
Superhero superhero;

// ArrayList to be filled with Laser objects
ArrayList<Laser> lasers = new ArrayList<Laser>();

// Space between Superhero and the bottom of the window
int superheroInset = 170;

// Background color
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
// Handles all the magic of creating the background, 
// making the Superhero move and shoot lasers.
void draw() {
  background(backgroundColor);  
  displayStarfieldBackground();

  displayPlanet();

  // Loop through the array list size and create the lasers
  for (int i = 0; i < lasers.size(); i++) {
    Laser l = (Laser)lasers.get(i);
    l.update(); 
    l.display();
  }

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

  // Checks if the spacebar is being pressed (spacebar keycode: 32)
  if (keyCode == 32) {
    // If it is, a new laser will be added to the array list
    lasers.add(new Laser());
  }
}

// keyReleased()
//
// Same as KeyPressed, except for released.
void keyReleased() {
  superhero.keyReleased();
}