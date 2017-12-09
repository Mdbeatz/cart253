class Meteor {
  /////////////// Properties ///////////////

  // Location, velocity, speed and size of the meteor
  int x;
  int y;
  int vx;
  int vy;
  int speed;
  int size;


  /////////////// Constructor ///////////////

  // Meteor()
  //
  //
  Meteor() {
    x = width/2;
    y = 0;

    speed = 5;

    vx = speed;
    vy = speed;

    size = 80;
  }


  /////////////// Methods ///////////////

  // reset()
  //
  //
  void reset() {
    x = floor(random(width));
    y = 0;
  }

  // update()
  //
  //
  void update() {
    x += vx;
    y += vy;
  }

  // collide()
  //
  //
  void collide() {
    if (abs(y - shieldY) < shieldHeight/2 && shieldOn == true && x > shieldX - shieldWidth/2 && x < shieldX + shieldWidth/2) {
      vy = -vy;
    }

    if (x + size/2 > width || x - size/2 < 0) {
      vx = -vx;
    } else if (y + size/2 < 0) {
      vy = -vy;
    } else if (y - size/2 > height) {
      reset();
    }

    if (dist(x, y, planet.planetX, planet.planetY) < planet.planetSize/2 ) {
      gameScreen = 2;
    }
  }

  // display()
  //
  //
  void display() {
    noStroke();
    fill(255);
    //ellipse(x, y, size, size);

    image(meteorSprite, x, y, size, size);
  }
}