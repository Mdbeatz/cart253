// Final Project
//
// PREPARED BY: Marianne De Bonis
//
//


// Loads a .vlw formatted font into a PFont object
PFont font;

// Array storing all the stars for the starBackground
StarBackground[] starBackground = new StarBackground[400];

// Array storing all the villlains
Villain[] villains = new Villain[6];

// Array storing all the villains2 for the 2nd row of villains
Villain[] villains2 = new Villain[6];

// Global variable for the superhero
Superhero superhero;

// ArrayList to be filled with image objects
ArrayList<PImage> hearts = new ArrayList<PImage>();

// Global variables for the heart image objects
PImage heart1;
PImage heart2;
PImage heart3;

// ArrayList to be filled with Laser objects
ArrayList<Laser> lasers = new ArrayList<Laser>();

// Variable to control which screen is active, according to the value of this variable...
// 0: Start screen
// 1: Game screen
// 2: Game over screen
int gameScreen = 0;

// Space between Superhero and the bottom of the window
int superheroInset = 170;

// Background color
color backgroundColor = color (8, 5, 45);

// Position, size and fill of the superhero's planet
int planetX;
int planetY;
int planetSize;
color planetFill = color(238, 174, 121, 255);

// Position, size and control statement for the superhero's shield
int shieldX;
int shieldY;
int shieldWidth;
int shieldHeight;
boolean shieldOn = false;


// setup()
//
// Sets the size and creates the Superhero
void setup() {
  size(700, 900);

  // Load the heart images in to the global variables
  heart1 = loadImage("heart.png");
  heart2 = loadImage("heart.png");
  heart3 = loadImage("heart.png");

  // Add the global variables of the heart images to the hearts ArrayList
  hearts.add(heart1);
  hearts.add(heart2);
  hearts.add(heart3);

  // Create the amount of stars that are stored in the starBackground array
  for (int i = 0; i < starBackground.length; i++) {
    int x = floor(random(width));
    int y = floor(random(height));
    int vy = floor(random(1, 3));
    int size = floor(random(1, 4));

    starBackground[i] = new StarBackground(x, y, vy, size);
  }

  // Create the amount of villains that are stored in the villains array
  for (int i = 0; i < villains.length; i++) {
    int x = i * 80 + 80;
    int y = 70;
    int speed = 2;
    int size = floor(random(50, 70));

    villains[i] = new Villain(x, y, speed, size);
  }

  // Create the amount of villains that are stored in the villains2 array for the 2nd row of villains
  for (int i = 0; i < villains2.length; i++) {
    int x = i * 80 + 80;
    int y = 150;
    int speed = 2;
    int size = floor(random(50, 70));

    villains2[i] = new Villain(x, y, speed, size);
  }

  // Create the superhero
  superhero = new Superhero(width/2, height - superheroInset);
}

// draw()
//
// Handles all the magic.
void draw() {
  background(backgroundColor);
  displayStarBackground();

  // Check for the gameScreen value and display contents of the chosen screen...
  // If gameScreen value is 0, display startScreen content...
  // If gameScreen value is 1, display gameScreen content...
  // If gameScreen value is 2, display gameOverScreen content...
  if (gameScreen == 0) {
    startScreen();
  } else if (gameScreen == 1) {
    gameScreen();
    displayHeader();
  } else if (gameScreen == 2) {
    gameOverScreen();
  }
}

// displayStarBackground
//
// Display the star background.
void displayStarBackground() {
  // Loop through all the stars one by one
  for (int i = 0; i < starBackground.length; i++) {
    starBackground[i].update();
    starBackground[i].display();
  }
}

// startScreen()
//
//
void startScreen() {
  rectMode(CENTER);
  stroke(255);
  strokeWeight(20);
  fill(255, 200);
  rect(width/2, height/3, 500, 200);

  font = loadFont("AmericanTypewriter-CondensedBold-48.vlw");
  textFont(font, 60); // sets which font is chosen and the size
  textAlign(CENTER);
  textSize(50);
  fill(backgroundColor);
  text("GAME TITLE", width/2, height/3);
}

// gameScreen()
//
//
void gameScreen() {
  displayPlanet();

  // Variable for checking if a villain hits the edge of the window.
  // Set to false when game starts.
  boolean hitsEdge = false;
  boolean hitsEdge2 = false;

  // Loop through the villains one by one
  for (int i = 0; i < villains.length; i++) {
    if (villains[i].energy == 0) {
      continue;
    }

    villains[i].update();
    villains[i].display();

    // Check if the villain's position is greater than the width OR less than 0.
    // Basically checking if the villain has hit the right edge of the window OR the left edge.
    if (villains[i].x + villains[i].size/2 > width || villains[i].x - villains[i].size/2 < 0) {
      // If it has, then hitsEdge is set to true
      hitsEdge = true;
    }
  }

  // Check if hitsEdge is true.
  if (hitsEdge) {
    // If it is, loop through the villains one by one
    for (int i = 0; i < villains.length; i++) {
      // hitsWall() method is called.
      // The villains will move in the opposite direction and shift downwards.
      villains[i].hitsWall();
    }
  }

  // Loop through the villains one by one for 2nd row of villains
  for (int i = 0; i < villains2.length; i++) {
    if (villains2[i].energy == 0) {
      continue;
    }

    villains2[i].update();
    villains2[i].display();

    // Check if the villain's position is greater than the width OR less than 0.
    // Basically checking if the villain has hit the right edge of the window OR the left edge.
    if (villains2[i].x + villains2[i].size/2 > width || villains2[i].x - villains2[i].size/2 < 0) {
      // If it has, then hitsEdge is set to true
      hitsEdge2 = true;
    }
  }

  // Check if hitsEdge is true for 2nd row of villains.
  if (hitsEdge2) {
    // If it is, loop through the villains one by one
    for (int i = 0; i < villains2.length; i++) {
      // hitsWall() method is called.
      // The villains will move in the opposite direction and shift downwards.
      villains2[i].hitsWall();
    }
  }

  // Loop through the lasers array list size and create the lasers
  for (int i = 0; i < lasers.size(); i++) {
    Laser l = (Laser)lasers.get(i);
    l.update(); 
    l.display();

    for (int j = 0; j < villains.length; j++) {
      if (l.hits(villains[j])) {
        villains[j].dies();
        l.disappear();
      }
    }

    for (int j = 0; j < villains2.length; j++) {
      if (l.hits(villains2[j])) {
        villains2[j].dies();
        l.disappear();
      }
    }
  }

  // Loop through the lasers array list size backwards
  for (int i = lasers.size()-1; i >= 0; i--) {
    Laser l = lasers.get(i);

    // Check if the getRemoved variable is true
    if (l.getRemoved) {
      // If it is, remove the laser being referenced from the array list
      lasers.remove(i);
    }
  }

  // Loop through the lasers array list
  for (int i = 0; i < lasers.size(); i++) {
    // Check if the laser hits the shield
    if (abs(lasers.get(i).y - shieldY) < shieldHeight/2 && shieldOn == true) { 
      // If it does, remove the indexed laser
      lasers.remove(i);
    }
  }

  superhero.update();
  superhero.display();

  if (shieldOn) {
    displayShield();
  }
}

// displayShield()
//
//
void displayShield() {
  shieldX = superhero.x;
  shieldY = superhero.y - superhero.superheroHeight/2 - 25;  
  shieldWidth = 300;
  shieldHeight = 15;

  rectMode(CENTER);
  noStroke();
  fill(255);
  rect(shieldX, shieldY, shieldWidth, shieldHeight);
}

// displayHeader()
//
//
void displayHeader() {
  rectMode(CENTER);
  fill(255);
  rect(width/2, 0, width, 65);

  textSize(16);
  fill(0);
  text("LIVES:", 20, 20);

  displayHearts();
}

// displayHearts()
//
//
void displayHearts() {
  imageMode(CENTER);
  
  // Loop through the hearts ArrayList
  for (int i=0; i<hearts.size(); i++) {
    // Display each heart next to each other
    image(hearts.get(i), 75 + 30*i, 15, 25, 25);
  }
}

// displayPlanet()
//
// Creates the Superhero's planet.
void displayPlanet() {
  planetX = width/2;
  planetY = height + 150;
  planetSize = 500;

  noStroke();
  fill(planetFill);
  ellipse(planetX, planetY, planetSize, planetSize);
}

// gameOverScreen()
//
//
void gameOverScreen() {
  fill(255, 0, 0);
  textSize(100);
  text("GAME OVER", width/2, height/2);
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

  if (keyCode == 's' || keyCode == 'S') {
    shieldOn = true;
    superhero.speed = 0;
  }
}

// keyReleased()
//
// Same as KeyPressed, except for released.
void keyReleased() {
  superhero.keyReleased();

  if (keyCode == 's' || keyCode == 'S') {
    shieldOn = false;  
    superhero.speed = superhero.defaultSpeed;
  }
}

void mousePressed() {
  if (gameScreen == 0) {
    startGame();
  }
}

void startGame() {
  gameScreen = 1;
}