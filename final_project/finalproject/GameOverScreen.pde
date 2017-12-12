// GameOverScreen
//
// A class that displays the game over screen content.

class GameOverScreen {
  
  // display()
  //
  // Display the text for the game over screen
  void display() {
    textAlign(CENTER);
    
    textFont(myFont, 60);
    fill(235, 45, 120);
    textSize(100);
    text("GAME OVER", width/2, (height/2) - 250);

    imageMode(CENTER);
    image(loseMeme, width/2, height/2, 500, 383);

    textSize(50);
    fill(224, 227, 57);
    text("Click to restart", width/2, (height/2) + 300);
    rectMode(CENTER);
    rect(width/2, (height/2) + 310, 300, 7);
  }
  
}