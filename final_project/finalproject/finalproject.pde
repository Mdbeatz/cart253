// ***FINAL PROJECT***
//
// A WEIRD SPACE INVADERS GAME WITH A SHIELD AND A HARD LEVEL 2 (THAT IS LIKE PONG BUT WITH A METEOR)
//
// PREPARED BY: Marianne De Bonis
//
// ***LEVEL 1***
// Protect the planet from the villains by killing them with lasers and using your shield. 
// You lose a life every time you get hit by a laser (you only have three lives) and the planet
// loses energy every time it gets hit by a villain's laser. Do not let the planet disappear.
//
// ***LEVEL 2***
// Same as level 2, but with a meteor flying around that acts like a Pong ball, and the villains
// are a bit faster. Use your shield to deflect the meteor away from the planet. If the meteor 
// hits the planet, YOU LOSE.
//
// ***CONTROLS***
// Left arrow key - Move left
// Right arrow key - Move right
// 'S' or 's' - Turn shield on 
// Spacebar - Shoot lasers
//
// ***ARTIST'S STATEMENT***
// The theme I was aiming for was a vibrant, tacky-looking space game; and I think I achieved that look. 
// I had a lot of fun creating the animated star background. My first idea was to just create a seamless image 
// of a star background and have it keep scrolling vertically through the window, but then looking back on 
// exercise07, I realized I can implement the same technique I used. I created bubbles that move downwards on 
// the y-axis within the window, and then once they exit b the bottom, they reset and spawn above the window 
// and come back downwards. For the bubbles to look like stars, I just had to make the sizes smaller and have 
// an Array of different star colors. The stars are also random sizes (between 1-4) and random speeds (between 1-3) 
// and this gives the impression of depth, that some stars are closer and some are farther away. I created the 
// superhero, villain, and heart sprites myself by using Piskel, a free online sprite editor. For the startScreen, 
// I created the superhero vector myself using Illustrator, and yes, I intentionally designed the superhero to look 
// like a Powerpuff Girl. For level 1, it’s pretty much a simple space invaders game, but to be more creative, 
// I added a few twists. I wanted the user to be able to use a shield (by simply displaying a rect when pressing the 
// spacebar) but to not make it too easy, I made it that the user cannot move nor can they shoot lasers when using 
// the shield (when spacebar is being pressed). Once the spacebar is released, the user can resume to moving around 
// and shooting lasers. Also, by using the energy technique (using alpha channels) from exercise04 with the griddie 
// life system, I used this to make the planet slowly disappear whenever it gets hit by a villain’s laser (alpha 
// channel decrements by 15 with every hit). The most challenging aspect for coding this game was to understand how 
// ArrayLists worked. Using ArrayLists was essential for both the superhero and villain lasers. I soon realized it 
// wasn’t that complicated; it was similar to making an array of objects, but with a list, you can add and remove 
// items from the list and it is resized dynamically. The lasers were simply added with the add() function, they were 
// indexed with the get() function, and are simply removed with the remove() function. 
// Shout out to Freesound.org for the great, free sound effects used in my game!


import processing.sound.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

// Globa variables for the sound effects
SoundFile backgroundMusic;
SoundFile villainLaserSound;
SoundFile villainDiesSound;
SoundFile superheroLaserSound;
SoundFile gameOverSound;
SoundFile winSound;
SoundFile superheroGetsHitSound;
SoundFile planetGetsHitSound;

// Loads a formatted font into a PFont object
PFont myFont;

// Global variables for the start screen, game over screen and player wins screen
StartScreen startScreen;
GameOverScreen gameOverScreen;
PlayerWinsScreen playerWinsScreen;

// Global variables for the resets for level 1 and resets for level 2
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

// Global variables for the superhero, planet and meteor
Superhero superhero;
Planet planet;
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
PImage superheroVector;
PImage meteorSprite;

// Variable for displaying current level
int currentLvl = 1;


// setup()
//
// Sets the size of the window, creates the font, the sounds, the screens, the superhero,
// the planet, the meteor, loads the hearts and character sprites, creates the star background,
// and the two rows of villains
void setup() {
  // Set the window size
  size(700, 800);

  // Create the font
  myFont = createFont("KGWhattheTeacherWants", 32);

  // Create all the sounds
  villainLaserSound = new SoundFile(this, "villainLaserSound.mp3");
  villainDiesSound = new SoundFile(this, "villainDiesSound.wav");
  superheroLaserSound = new SoundFile(this, "superheroLaserSound.wav");
  superheroGetsHitSound = new SoundFile(this, "superheroGetsHitSound.wav");
  planetGetsHitSound = new SoundFile(this, "planetGetsHitSounds.wav");
  gameOverSound = new SoundFile(this, "gameOverSound.wav");
  winSound = new SoundFile(this, "winSound.wav");
  backgroundMusic = new SoundFile(this, "backgroundMusic.mp3");

  // Set the background music to loop through the game with a lower amplitude/volume
  backgroundMusic.loop();
  backgroundMusic.amp(0.6);

  // Create the screens
  startScreen = new StartScreen();
  gameOverScreen = new GameOverScreen();
  playerWinsScreen = new PlayerWinsScreen();

  // Create the level resets for levels 1 and 2
  level1Resets = new Level1Resets();
  level2Resets = new Level2Resets();

  // Create the superhero, planet and the meteor
  superhero = new Superhero(width/2, height - superheroInset);
  planet = new Planet();
  meteor = new Meteor();

  // Load the heart images into the global variables
  heart1 = loadImage("heart.png");
  heart2 = loadImage("heart.png");
  heart3 = loadImage("heart.png");

  // Add the global variables of the heart images to the hearts ArrayList
  hearts.add(heart1);
  hearts.add(heart2);
  hearts.add(heart3);  

  // Load the meme images and character images into their variables
  loseMeme = loadImage("picardmeme.jpg");
  winMeme = loadImage("gatsbymeme.jpg");
  villainSprite = loadImage("villain.png");
  superheroSprite = loadImage("superhero.png");
  superheroVector = loadImage("superheroVector.png");
  meteorSprite = loadImage("meteor.png");

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
}

// draw()
//
// Handles all the magic.
void draw() {
  // Display background color
  background(backgroundColor);

  // Display star background
  displayStarBackground();

  // Check for the gameScreen value and display contents of the chosen screen...
  // If gameScreen value is 0, display startScreen content... If gameScreen value is 1, display gameScreen content...
  // If gameScreen value is 2, display gameOverScreen content... If gameScreen value is 3, display playerWinsScreen content.
  if (gameScreen == 0) {
    startScreen.display();
  } else if (gameScreen == 1) {
    // Display the game
    gameScreen();

    // Display the header
    displayHeader();

    // Update and display the planet
    planet.update();
    planet.display();

    // Check if meteorOn == true,
    if (meteorOn) {
      // If it is, update and display the meteor, and check for collisions
      meteor.update();
      meteor.display();
      meteor.collide();
    }
  } else if (gameScreen == 2) {
    // Display the game over screen contents
    gameOverScreen.display();
  } else if (gameScreen == 3) {
    // Display the player wins screen contents
    playerWinsScreen.display();
  }
}

// displayStarBackground
//
// Display the star background.
void displayStarBackground() {
  // Loop through all the stars one by one
  for (int i = 0; i < starBackground.length; i++) {
    // Update the star
    starBackground[i].update();

    // Display the star
    starBackground[i].display();
  }
}

// gameScreen()
//
// Display the game
void gameScreen() {  
  // Update and display the superhero
  superhero.update();
  superhero.display();

  // Check if shieldOn == true,
  if (shieldOn) {
    // If it is, display the shield
    displayShield();
  }
  
  // Variables for checking if a villain hits the edge of the window.
  // hitsEdge is for villains and hitsEdge2 is for villains2. Both are set to false when game starts.
  boolean hitsEdge = false;
  boolean hitsEdge2 = false;

  // Loop through the villains one by one
  for (int i = 0; i < villains.length; i++) {
    // Check if the indexed villain's energy is equal to 0
    if (villains[i].energy == 0) {
      // If it is, start the next iteration
      continue;
    }

    // Update and display the indexed villain, and check if it reaches the superhero
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
    // Check if the indexed villain's energy is equal to 0
    if (villains2[i].energy == 0) {
      // If it is, start the next iteration
      continue;
    }

    // Update and display the indexed villain, and check if it reaches the superhero
    villains2[i].update();
    villains2[i].display();
    villains2[i].reachesSuperhero();

    // Check if the villain's position is greater than the width OR less than 0.
    // Basically checking if the villain has hit the right edge of the window OR the left edge.
    if (villains2[i].x + villains2[i].size/2 > width || villains2[i].x - villains2[i].size/2 < 0) {
      // If it has, then hitsEdge2 is set to true
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
    
    // Update and display the laser
    l.update(); 
    l.display();
    
    // Loop through the first row of villains
    for (int j = 0; j < villains.length; j++) {
      if (l.hits(villains[j])) {
        // Indexed villain dies
        villains[j].dies();
        
        // Remove laser that hits the indexed villain
        l.disappear();
        
        // Increment the deadVillainsRow1Count by 1
        deadVillainsRow1Count++;
      }
    }

    // Loop through the second row of villains
    for (int j = 0; j < villains2.length; j++) {
      if (l.hits(villains2[j])) {
        // Indexed villain dies
        villains2[j].dies();
        
        // Remove laser that hits the indexed villain
        l.disappear();
        
        // Increment the deadVillainsRow2Count by 1
        deadVillainsRow2Count++;
      }
    }
  }

  // Check if all the villains are dead
  if (deadVillainsRow1Count == villains.length && deadVillainsRow2Count == villains2.length && deadVillainsRow1Count == deadVillainsRow2Count) {
    // If they are all dead, gameScreen is set to 3, therefore showing displaying the player wins screen
    gameScreen = 3;

    // Play the win sound
    winSound.play();
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
}

// displayShield()
//
// Display the shield
void displayShield() {
  // Set the position and size of the shield
  shieldX = superhero.x;
  shieldY = superhero.y - superhero.superheroHeight/2 - 25;  
  shieldWidth = 350;
  shieldHeight = 15;

  // Draw rect using CENTER mode, no stroke, and a white fill
  rectMode(CENTER);
  noStroke();
  fill(255);
  rect(shieldX, shieldY, shieldWidth, shieldHeight);
}

// displayHeader()
//
// Display the header
void displayHeader() {
  // Draw rect using CENTER mode, with a white fill and up at the top of the window
  rectMode(CENTER);
  noStroke();
  fill(255);
  rect(width/2, 0, width, 65);

  // Display the text for the lives and current level with text size of 16 and black fill
  textSize(16);
  fill(0);
  text("LIVES:", 30, 15);
  text("LEVEL: " + currentLvl, 300, 15 );

  // Display the hearts
  displayHearts();
}

// displayHearts()
//
// Display hearts/superhero lives
void displayHearts() {
  // Loop through the hearts ArrayList
  for (int i=0; i<heartsSize; i++) {
    // Draw image using CENTER mode
    imageMode(CENTER);

    // Display each heart next to each other
    image(hearts.get(i), 75 + 30*i, 15, 25, 25);
  }
}

// startGame()
//
// Start the game
void startGame() {
  // set gameScreen to 1, so now the gameScreen will be displayed
  gameScreen = 1;

  // set meteorOn to false, so the meteor does not display
  meteorOn = false;
}

// keyPressed()
//
// The superhero needs to know if it should move based on keypress,
// so when the keypress is detected in the main program we need to tell the superhero.
void keyPressed() {
  // Call the superhero's keyPressed method
  superhero.keyPressed();

  // Checks if the spacebar is being pressed (spacebar keycode: 32)
  if (keyCode == 32 && gameScreen != 0 && gameScreen != 2 && gameScreen != 3) {
    // If it is, a new laser will be added to the array list
    lasers.add(new Laser());

    // Play the superhero laser sound
    superheroLaserSound.play();
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
  // Call the superhero's keyReleased method
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
// Checks for mouse clicks
void mousePressed() {
  // Check if the mouse is being clicked when gameScreen equals 0 / start screen is displayed
  if (gameScreen == 0) {
    // If it is, start the game
    startGame();
  }

  // Check if the mouse is being clicked when gameScreen equals 2 / game screen is displayed
  if (gameScreen == 2) {
    // If it is, reset to play level 1 again
    level1Resets.display();

    // Reset meteor
    meteor.reset();
  }

  // Check if the mouse is being clicked when gameScreen equals 3 / player wins screen is displayed
  if (gameScreen == 3) {
    // If it is, reset to play level 2
    level2Resets.display();

    // Set meteorOn to true, so the meteor will be displayed
    meteorOn = true;
  }
}