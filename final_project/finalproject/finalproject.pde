// FINAL PROJECT
//
// A WEIRD SPACE INVADERS GAME WITH A SHIELD AND A HARD LEVEL 2 (THAT IS LIKE PONG BUT WITH A METEOR)
//
// PREPARED BY: Marianne De Bonis
//
// ABOUT THE GAME:
//    blablabla....
//
// CONTROLS:
//    Left arrow key - Move left
//    Right arrow key - Move right
//    'S' or 's' - Turn shield on 
//    Spacebar - Shoot lasers
//
// ACKNOWLEDGEMENTS:
//    blablabla...

// The moon level... Cause it's up there...


// Loads a .vlw formatted font into a PFont object
PFont myFont;

// Global variables for the start screen, game over screen and player wins screen
StartScreen startScreen;
GameOverScreen gameOverScreen;
PlayerWinsScreen playerWinsScreen;

Level1Resets level1Resets;
Level2Resets level2Resets;

// Array storing all the stars for the starBackground
StarBackground[] starBackground = new StarBackground[400];

// Array storing all the villlains
Villain[] villains = new Villain[6];

// Array storing all the villains2 for the 2nd row of villains
Villain[] villains2 = new Villain[6];

// Counters for counting how many villains have died
int deadVillainsRow1Count;
int deadVillainsRow2Count;

// Global variable for the superhero
Superhero superhero;

// Global variable for the planet
Planet planet;

// Global variable for the meteor
Meteor meteor;

// Boolean variable to display the meteor only for level 2
// Initially set to false so it does not appear in level 1
boolean meteorOn = false;

// ArrayList to be filled with image objects
ArrayList<PImage> hearts = new ArrayList<PImage>();

// Global variables for the heart images
PImage heart1;
PImage heart2;
PImage heart3;

// Counter for the hearts
int heartsSize = 3;

// ArrayList to be filled with Laser objects
ArrayList<Laser> lasers = new ArrayList<Laser>();

// Variable to control which screen is active, according to the value of this variable...
// 0: Start screen
// 1: Game screen
// 2: Game over screen
// 3: Wins screen
int gameScreen = 0;

// Space between Superhero and the bottom of the window
int superheroInset = 170;

// Background color
color backgroundColor = color (8, 5, 45);

// Position, size and control statement for the superhero's shield
int shieldX;
int shieldY;
int shieldWidth;
int shieldHeight;
boolean shieldOn = false;

// Global variables for the win and lose meme images
PImage winMeme;
PImage loseMeme;

// Global variables for the villain, superhero and meteor images
PImage villainSprite;
PImage superheroSprite;
PImage meteorSprite;

PImage superheroVector;

// Variable for displaying current level
int currentLvl = 1;


// setup()
//
// Sets the size and creates the Superhero
void setup() {
  size(700, 800);
  
  myFont = createFont("KGWhattheTeacherWants", 32);

  // Create the screens
  startScreen = new StartScreen();
  gameOverScreen = new GameOverScreen();
  playerWinsScreen = new PlayerWinsScreen();
  
  level1Resets = new Level1Resets();
  level2Resets = new Level2Resets();

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

  // Load the heart images into the global variables
  heart1 = loadImage("heart.png");
  heart2 = loadImage("heart.png");
  heart3 = loadImage("heart.png");

  // Add the global variables of the heart images to the hearts ArrayList
  hearts.add(heart1);
  hearts.add(heart2);
  hearts.add(heart3);

  // Create the planet
  planet = new Planet();

  // Create the meteor
  meteor = new Meteor();

  // Load the meme images into their variables
  loseMeme = loadImage("picardmeme.jpg");
  winMeme = loadImage("gatsbymeme.jpg");

  // Load the character images into their variables
  villainSprite = loadImage("villain.png");
  superheroSprite = loadImage("superhero.png");
  meteorSprite = loadImage("meteor.png");
  
  superheroVector = loadImage("superheroVector.png");
}

// draw()
//
// Handles all the magic.
void draw() {
  background(backgroundColor);
  displayStarBackground();

  // Check for the gameScreen value and display contents of the chosen screen...
  // If gameScreen value is 0, display startScreen content... If gameScreen value is 1, display gameScreen content...
  // If gameScreen value is 2, display gameOverScreen content... If gameScreen value is 3, display playerWinsScreen content.
  if (gameScreen == 0) {
    startScreen.display();
  } else if (gameScreen == 1) {
    gameScreen();
    
    displayHeader();
    
    planet.update();
    planet.display();
    
    if (meteorOn) {
      meteor.update();
      meteor.display();
      meteor.collide();
    }
  } else if (gameScreen == 2) {
    gameOverScreen.display();
  } else if (gameScreen == 3) {
    playerWinsScreen.display();
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

// gameScreen()
//
//
void gameScreen() {  
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
    villains[i].reachesSuperhero();

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
        deadVillainsRow1Count++;
      }
    }

    for (int j = 0; j < villains2.length; j++) {
      if (l.hits(villains2[j])) {
        villains2[j].dies();
        l.disappear();
        deadVillainsRow2Count++;
      }
    }
  }

  if (deadVillainsRow1Count == villains.length && deadVillainsRow2Count == villains2.length && deadVillainsRow1Count == deadVillainsRow2Count) {
    gameScreen = 3;
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
  shieldWidth = 350;
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
  text("LIVES:", 30, 15);

  displayHearts();

  text("LEVEL: " + currentLvl, 300, 15 );
}

// displayHearts()
//
//
void displayHearts() {
  imageMode(CENTER);

  // Loop through the hearts ArrayList
  for (int i=0; i<heartsSize; i++) {
    // Display each heart next to each other
    image(hearts.get(i), 75 + 30*i, 15, 25, 25);
  }
}

// startGame()
//
//
void startGame() {
  gameScreen = 1;
  meteorOn = false;
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

  // Check if the 's' key is being pressed in both lower and upper case states
  if (keyCode == 's' || keyCode == 'S') {
    // If it is pressed, shieldOn becomes TRUE and the shield is displayed
    shieldOn = true;

    // The superhero's speed is set to 0 to stop the user from moving when the shield is displayed
    superhero.speed = 0;
  }
}

// keyReleased()
//
// Same as KeyPressed, except for released.
void keyReleased() {
  superhero.keyReleased();

  // Check if the 's' key is being pressed in both lower and upper case states
  if (keyCode == 's' || keyCode == 'S') {
    // If it is released, shieldOn becomes false and the shield goes away
    shieldOn = false;

    // The superhero's speed is set back to its default value so it can move again
    superhero.speed = superhero.defaultSpeed;
  }
}

// mousePressed()
//
// 
void mousePressed() {
  // If the start screen is displayed, click to start game
  if (gameScreen == 0) {
    startGame();
  }

  // If the game over screen is displayed, click to restart game
  if (gameScreen == 2) {
    level1Resets.display();
    meteor.reset();
  }

  // If the win screen is displayed, click to restart game
  if (gameScreen == 3) {
    level2Resets.display();
    meteorOn = true;
  }
}