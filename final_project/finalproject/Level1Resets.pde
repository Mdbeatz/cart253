// Level1Resets
//
// A class that resets values for level 1

class Level1Resets {

  void display() {
    currentLvl = 1;

    // Reset the 1st row of villains
    // Create the amount of villains that are stored in the villains array
    for (int i = 0; i < villains.length; i++) {
      int x = i * 80 + 80;
      int y = 70;
      int speed = 2;
      int size = floor(random(50, 70));

      villains[i] = new Villain(x, y, speed, size);
    }

    // Reset the 2nd row of villains
    // Create the amount of villains that are stored in the villains2 array for the 2nd row of villains
    for (int i = 0; i < villains2.length; i++) {
      int x = i * 80 + 80;
      int y = 150;
      int speed = 2;
      int size = floor(random(50, 70));

      villains2[i] = new Villain(x, y, speed, size);
    }

    deadVillainsRow1Count = 0;
    deadVillainsRow2Count = 0;

    // Reset superhero location
    superhero.x = width/2;
    superhero.y = height - superheroInset;

    // Reset hearts
    heartsSize = 3;

    // Reset planet
    planet.planetFillAlpha = 255;
    planet.display();

    // Start the game
    startGame();
  }
}