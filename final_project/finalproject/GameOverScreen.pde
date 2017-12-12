// GameOverScreen
//
// A class that displays the game over screen content.

class GameOverScreen {
  
  // display()
  //
  // Display the text for the game over screen
  void display() {
    // Display text using CENTER alignment
    textAlign(CENTER);
    
    // "GAME OVER" text
    textFont(myFont, 60);
    fill(235, 45, 120);
    textSize(100);
    text("GAME OVER", width/2, (height/2) - 250);

    // Lose meme
    // Draw image using CENTER mode
    imageMode(CENTER);
    image(loseMeme, width/2, height/2, 500, 383);

    // "Click to restart" text
    textSize(50);
    fill(224, 227, 57);
    text("Click to restart", width/2, (height/2) + 300);
    
    // Underline
    rectMode(CENTER);
    rect(width/2, (height/2) + 310, 300, 7);
  }  
}