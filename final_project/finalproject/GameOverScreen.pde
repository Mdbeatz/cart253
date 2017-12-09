// GameOverScreen
//
//

class GameOverScreen {
  
  void display() {
    fill(255, 0, 0);
    textSize(100);
    text("GAME OVER", width/2, 200);

    image(loseMeme, width/2, 500, 500, 383);

    textSize(50);
    text("Click to restart", width/2, 750);
  }
  
}