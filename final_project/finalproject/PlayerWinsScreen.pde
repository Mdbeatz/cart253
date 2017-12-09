// PlayerWinsScreen
//
//

class PlayerWinsScreen {

  void display() {
    fill(255, 0, 0);
    textSize(100);
    text("YOU WON!", width/2, 200);

    image(winMeme, width/2, 500, 500, 330);

    textSize(50);
    text("Click to restart", width/2, 750);
  }
}