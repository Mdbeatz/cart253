// Bubble
//
//

class Bubble {
  
  /////////////// Properties ///////////////

  int x;
  int y;

  int vy;

  int size;

  // Array of colors
  color[] dottieColors = {color(230, 132, 156), color(230, 206, 132), color(132, 230, 206)};

  // Set the fill to be a random color from the array of dottieColors
  color fill = dottieColors[(int)random(3)];
}