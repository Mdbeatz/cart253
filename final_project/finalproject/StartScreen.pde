// StartScreen
//
// A class that displays the start screen content.

class StartScreen {

  // display()
  //
  // Display the text for the player wins screen
  void display() {
    // Black transparent rect behind the game title
    rectMode(CENTER);
    fill(0, 180);
    rect(350, 178, 660, 140); 

    // Game title
    textFont(myFont, 60);
    textAlign(CENTER, CENTER);
    textSize(50);
    fill(235, 45, 120);
    text("A WEIRD SPACE INVADERS GAME", width/2, 140);
    textSize(35);
    fill(89, 197, 203);
    text("WITH A SHIELD AND A HARD LEVEL 2", width/2, 182);
    fill(224, 227, 57);
    text("(THAT IS LIKE PONG BUT WITH A METEOR)", width/2, 217);

    textAlign(CENTER, CENTER);
    textSize(40);
    fill(89, 197, 203);
    text("Click to start", width/2, 340);
    rectMode(CENTER);
    rect(width/2, 368, 200, 5);

    textAlign(CENTER, CENTER);
    textSize(30);
    fill(235, 45, 120);
    text("*** CONTROLS ***", width/2, 450);
    fill(224, 227, 57);
    textSize(25);
    text("Left + right arrow keys to move", width/2, 480);
    text("Space bar to shoot lasers", width/2, 505);
    text("'s' key to use shield", width/2, 530);

    textSize(30);
    fill(235, 45, 120);
    text("*** WARNING ***", width/2, 600);
    textSize(25);
    fill(224, 227, 57);
    text("Get shot 3 times: YOU LOSE", width/2, 630);
    text("The planet completely fades away: YOU LOSE", width/2, 655);
    text("Level 2: The planet gets hit by a meteor: YOU LOSE", width/2, 685);

    textSize(30);
    fill(89, 197, 203);
    text("HAVE FUN!!!", width/2, 740);

    image(superheroVector, 60, 280, 130, 140);
    image(villainSprite, 600, 290, 70, 70);
    image(villainSprite, 510, 270, 70, 70);
    image(villainSprite, 530, 350, 70, 70);
  }
}