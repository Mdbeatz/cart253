// PlayerWinsScreen
//
// A class that displays the player wins screen content.

class PlayerWinsScreen {

  // display()
  //
  // Display the text for the player wins screen
  void display() {
    textFont(myFont, 60);
    fill(255, 0, 0);
    textSize(100);
    text("YOU WON!", width/2, 200);

    image(winMeme, width/2, 500, 500, 330);

    textSize(50);
    text("Click to restart", width/2, 750);
  }
}