// Griddies
// by Pippin Barr
// MODIFIED BY: Marianne De Bonis
//
// A simple artificial life system on a grid. The "griddies" are squares that move
// around randomly, using energy to do so. They gain energy by overlapping with
// other griddies. If a griddie loses all its energy it dies.

// CHANGED
// The size of a single grid element
int gridSize = 22;

// ADDED
// The new size of a single grid element
int newGridSize = 50;

// CHANGED
// An array storing all the griddies
Griddie[] griddies = new Griddie[300];

// ADDED
// The size of a single dottie
int dotSize = 25;

// ADDED 
// An Array storing all the dotties
Dottie[] dotties = new Dottie[150];

// setup()
//
// Set up the window and the griddies
void setup() {
  // CHANGED
  // Set up the window size and framerate (lower so we can watch easier)
  size(800, 600);
  frameRate(10);

  // QUESTION: What does this for loop do?
  // Creates the amount of griddies that are stored in the array at random locations 
  // within the window and sets their sizes.
  for (int i = 0; i < griddies.length; i++) {
    int x = floor(random(0, width/gridSize));
    int y = floor(random(0, height/gridSize));
    griddies[i] = new Griddie(x * gridSize, y * gridSize, gridSize);
  }

  // ADDED
  // Creates the amount of dotties that are stored in the array at random locations 
  // within the window and sets their sizes.
  for (int i = 0; i < dotties.length; i++) {
    int x = floor(random(0, width/gridSize));
    int y = floor(random(0, height/gridSize));
    dotties[i] = new Dottie(x * dotSize, y * dotSize, dotSize);
  }
}

// draw()
//
// Update all the griddies, check for collisions between them, display them.
// Update all the dotties, check for collisions between them, display them.
void draw() {
  // CHANGED
  background(30);

  // We need to loop through all the griddies one by one
  for (int i = 0; i < griddies.length; i++) {
    // Update the griddies
    griddies[i].update();

    // Now go through all the griddies a second time...
    for (int j = 0; j < griddies.length; j++) {
      // QUESTION: What is this if-statement for?
      // Checks if the j indexed number is NOT EQUAL to the i indexed number.
      // If they are not the same value, that means they will be indexing two different Griddies,
      // and the method to check if they are colliding can be called.
      if (j != i) {
        // QUESTION: What does this line check?
        // Checks if the Griddie indexed by i has collided with the Griddie indexed by j. 
        griddies[i].collide(griddies[j]);
      }
    }
    
    // ADDED
    // Now go through all the dotties to check for collision with the griddies...
    for (int j = 0; j < dotties.length; j++) {
      // Checks if the griddie indexed by i has collided with the dottie indexed by j.
        griddies[i].collide(dotties[j]);
    }

    // Display the griddies
    griddies[i].display();
  }

  // We need to loop through all the Dotties one by one
  for (int i = 0; i < dotties.length; i++) {
    // Update the dotties
    dotties[i].update();

    // Now go through all the Dotties a second time...
    for (int j = 0; j < dotties.length; j++) {
      // Checks if the j indexed number is NOT EQUAL to the i indexed number.
      // If they are not the same value, that means they will be indexing two different Dotties,
      // and the method to check if they are colliding can be called.
      if (j != i) {
        // Checks if the Dottie indexed by i has collided with the Dottie indexed by j. 
        dotties[i].collide(dotties[j]);
      }
    }

    // Display the dotties
    dotties[i].display();
  }
}