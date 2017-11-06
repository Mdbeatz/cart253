// Exercise 07
//
// MODIFIED BY: Marianne De Bonis


// An array of bouncers to play with
Bouncer[] bouncers = new Bouncer[15];

// setup()
//
// Creates the bouncers.
void setup() {
  size(640, 480);

  // Go through the length of an array adding new objects to it (Bouncers in this case)
  for (int i = 0; i < bouncers.length; i++) {
    // Each Bouncer just starts with random values
    bouncers[i] = new Bouncer(random(0, width), random(0, height), random(-10, 10), random(-10, 10), random(30, 60), color(0, random(255), random(255)));
  }
}

// draw()
//
void draw() {
  background(255, 204, 0);

  // Run through the length of an array to update and display objects, in this case Bouncers.
  for (int i = 0; i < bouncers.length; i++) {
    bouncers[i].update();
    bouncers[i].display();

    for (int j = 0; j < bouncers.length; j++) {
      if (j != i) {
        bouncers[i].collide(bouncers[j]);
      }
    }
  }
}