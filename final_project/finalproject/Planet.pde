// Planet
//
// A class that defines the planet at the bottom of the screen
// that constantly moves from right to left

class Planet {
  /////////////// Properties ///////////////

  // Locatiion, x-velocity, size, fill and alpha channel for the planet
  int planetX;
  int planetY;
  int planetVX;
  int planetSize;
  color planetFill = color(52, 219, 219);
  int planetFillAlpha = 255;


  /////////////// Constructor ///////////////

  // Planet()
  //
  //
  Planet() {
    planetX = width/2;
    planetVX = 2;
    planetY = height + 150;
    planetSize = 500;
    planetFill = color (52, 219, 219);
  }


  /////////////// Methods ///////////////

  // update()
  //
  // Move the planet left and right.
  void update() {
    planetX += planetVX;

    // Check for wall colli
    if (planetX - planetSize/2 < 0 ) {
      planetVX = -planetVX;
    } else if (planetX + planetSize/2 > width) {
      planetVX = -planetVX;
    }
  }

  // display()
  //
  // Displat the planet.
  void display() {
    noStroke();
    fill(planetFill,planetFillAlpha);
    ellipse(planetX, planetY, planetSize, planetSize);
  }
}