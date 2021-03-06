// PlayerWinsScreen
//
// A class that displays the player wins screen content.

class PlayerWinsScreen {

  // display()
  //
  // Display the text for the player wins screen
  void display() {
    // Display text using CENTER alignment
    textAlign(CENTER);

    // "YOU SUCCEEDED" text
    textFont(myFont, 60);
    fill(235, 45, 120);
    textSize(100);
    text("YOU SUCCEEDED", width/2, (height/2) - 250);

    // Win meme
    // Draw image using CENTER mode
    imageMode(CENTER);
    image(winMeme, width/2, height/2, 500, 383);

    // "Click to play level 2" text
    textSize(40);
    fill(89, 197, 203);
    text("Click to play level 2", width/2, (height/2) + 290);

    // Underline
    rectMode(CENTER);
    rect(width/2, (height/2) + 303, 300, 7);
    
    // Note for level 2
    textSize(30);
    fill(224, 227, 57);
    text("***Use the shield as the paddle for the meteor***", width/2, (height/2) + 350);
  }
}