// StartScreen
//
//

class StartScreen {
  
  void display() {
    font = loadFont("AmericanTypewriter-CondensedBold-48.vlw");
    textFont(font, 60); // sets which font is chosen and the size
    textAlign(CENTER, CENTER);
    textSize(50);
    fill(255);
    text("A weird space invaders game", width/2, 275);
    text("with a shield", width/2, 330);

    textAlign(CENTER, CENTER);
    textSize(50);
    fill(255);
    text("Click to start", width/2, 475);

    textAlign(CENTER, CENTER);
    textSize(40);
    fill(255);
    text("Controls:", width/2, 590);
    textSize(30);
    text("Left + right arrow keys to move", width/2, 630);
    text("Space bar to shoot lasers", width/2, 665);
    text("'s' key to use shield", width/2, 700);

    text("Get shot 3 times: YOU LOSE", width/2, 765);
    text("The planet completely fades away: YOU LOSE", width/2, 800);
  }
  
}