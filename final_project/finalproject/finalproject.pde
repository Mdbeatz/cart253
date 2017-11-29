// Final Project
//
// PREPARED BY: Marianne De Bonis
//
//


int gameScreen = 0;

// Array storing all the stars for the starBackground
StarBackground[] starBackground = new StarBackground[400];

PImage heart1;
PImage heart2;
PImage heart3;

// Array storing all the villlains
Villain[] villains = new Villain[6];

// Array storing all the villains2 for the 2nd row of villains
Villain[] villains2 = new Villain[6];

// Global variable for the superhero
Superhero superhero;

// ArrayList to be filled with Laser objects
ArrayList<Laser> lasers = new ArrayList<Laser>();

// Space between Superhero and the bottom of the window
int superheroInset = 170;

// Background color
color backgroundColor = color (8, 5, 45);

int planetX;
int planetY;
int planetSize;
color planetFill = color(238, 174, 121, 255);

int shieldX;
int shieldY;
int shieldWidth;
int shieldHeight;
boolean shieldOn = false;


// setup()
//
// Sets the size and creates the Superhero
void setup() {
  size(700, 850);

  heart1 = loadImage("heart.png");
  heart2 = loadImage("heart.png");
  heart3 = loadImage("heart.png");

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

  superhero = new Superhero(width/2, height - superheroInset);
}

// draw()
//
// Handles all the magic.
void draw() {
  background(backgroundColor);
  displayStarBackground();

  if (gameScreen == 0) {
    initScreen();
  } else if (gameScreen == 1) {
    gameScreen();
  } else if (gameScreen == 2) {
    gameOverScreen();
  }
}

// initScreen()
//
//
void initScreen() {
  rectMode(CENTER);
  stroke(255);
  strokeWeight(20);
  fill(255,200);
  rect(width/2, height/3, 500, 300);
  
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

  superhero.update();
  superhero.display();

  if (shieldOn) {
    displayShield();
  }

  displayHeader();
}

// gameOverScreen()
//
//
void gameOverScreen() {
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
  text("LIVES:", 10, 20);

  imageMode(CENTER);
  image(heart1, 75, 15, 25, 25);
  image(heart2, 105, 15, 25, 25);
  image(heart3, 135, 15, 25, 25);
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