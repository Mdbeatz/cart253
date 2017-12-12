// GameOverScreen
//
// A class that displays the game over screen content.

class GameOverScreen {
  
  // display()
  //
  // Display the text for the game over screen
  void display() {
    textFont(myFont, 60);
    fill(255, 0, 0);
    textSize(100);
    text("GAME OVER", width/2, 200);

    image(loseMeme, width/2, 500, 500, 383);

    textSize(50);
    text("Click to restart", width/2, 750);
  }
  
}