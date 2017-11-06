// Exercise 06
//
// MODIFIED BY: Marianne De Bonis
//
// Using the webcam as input to play with Bouncers.
// Bouncers change colour and change size when they collide with the brighest pixel.
// Depending on where the brightest pixel is in the window, the video gets brighter or darker.
//
// Note: The brightest pixel is best controlled by using a flashlight.

// Import the video library
import processing.video.*;

// The capture object for reading from the webcam
Capture video;

// A PVector allows us to store an x and y location in a single object
// When we create it we give it the starting x and y (which I'm setting to -1, -1
// as a default value)
PVector brightestPixel = new PVector(-1, -1);

// CHANGED bouncer amount
// An array of bouncers to play with
Bouncer[] bouncers = new Bouncer[15];

// setup()
//
// Creates the bouncers and starts the webcam

void setup() {
  size(640, 480);

  // Our old friend the for-loop used to go through the length of an
  // array adding new objects to it (Bouncers in this case)
  for (int i = 0; i < bouncers.length; i++) {
    // Each Bouncer just starts with random values 
    // CHANGED color
    bouncers[i] = new Bouncer(random(0, width), random(0, height), random(-10, 10), random(-10, 10), random(20, 50), color(0, 0, (random(255))));
  }

  // Start up the webcam
  video = new Capture(this, 640, 480, 30);
  video.start();
  
  // ADDED
  // Load the pixels[] array so they can be manipulated inside draw()
  video.loadPixels();
  loadPixels();
}

// draw()
//
// Processes the frame of video, draws the video to the screen, updates the Bouncers
// and then just draws an ellipse at the brightest pixel location. You code should
// do something much more interesting in order to actually interact with the Bouncers.

void draw() {
  // A function that processes the current frame of video
  handleVideoInput();

  // Draw the video frame to the screen
  image(video, 0, 0);

  // ADDED
  // A function that adjusts the brightness of the video
  videoBrightness();

  // Our old friend the for-loop running through the length of an array to
  // update and display objects, in this case Bouncers.
  // If the brightness (or other video property) is going to interact with all the
  // Bouncers, it will need to happen in here.
  for (int i = 0; i < bouncers.length; i++) {
    bouncers[i].update();
    bouncers[i].display();
  }

  // For now we just draw a crappy ellipse at the brightest pixel
  fill(#ff0000);
  stroke(#ffff00);
  strokeWeight(10);
  ellipse(brightestPixel.x, brightestPixel.y, 20, 20);
}

// handleVideoInput
//
// Checks for available video, reads the frame, and then finds the brightest pixel
// in that frame and stores its location in brightestPixel.

void handleVideoInput() {
  // Check if there's a frame to look at
  if (!video.available()) {
    // If not, then just return, nothing to do
    return;
  }

  // If we're here, there IS a frame to look at so read it in
  video.read();

  // Start with a very low "record" for the brightest pixel
  // so that we'll definitely find something better
  float brightnessRecord = 0;

  // Go through every pixel in the grid of pixels made by this
  // frame of video
  for (int x = 0; x < video.width; x++) {
    for (int y = 0; y < video.height; y++) {
      // Calculate the location in the 1D pixels array
      int loc = x + y * width;
      // Get the color of the pixel we're looking at
      color pixelColor = video.pixels[loc];
      // Get the brightness of the pixel we're looking at
      float pixelBrightness = brightness(pixelColor);
      // Check if this pixel is the brighest we've seen so far
      if (pixelBrightness > brightnessRecord) {
        // If it is, change the record value
        brightnessRecord = pixelBrightness;
        // Remember where this pixel is in the the grid of pixels
        // (and therefore on the screen) by setting the PVector
        // brightestPixel's x and y properties.
        brightestPixel.x = x;
        brightestPixel.y = y;
      }
    }
  }

  // ADDED
  //
  // Go through all the bouncers
  for (int i = 0; i < bouncers.length; i++) {
    // Check if a bouncer collides with the brightest pixel
    if ((dist(bouncers[i].x, bouncers[i].y, brightestPixel.x, brightestPixel.y) < bouncers[i].size/2)) {
      // If it does, change the bouncer's fill color to a random color
      bouncers[i].fillColor = color(255, random(255), random(255));

      // Change the bouncer's size
      bouncers[i].size = bouncers[i].newSize;
    }
  }
}

// ADDED
// videoBrightness()
//
// Changes the brightness of the video based on the location of the brightest pixel.
// The video gets darker if the brightest pixel is more towards the left and if if it is
// more towards the right side of the window the video gets brighter. 

void videoBrightness() {
  // Go through the video pixels 
  for (int x = 0; x < video.width; x++ ) {
    for (int y = 0; y < video.height; y++ ) {

      // Calculate the 1D pixel location
      int loc = x + y*video.width;

      // Get the RGB values from the video
      float r = red  (video.pixels[loc]);
      float g = green (video.pixels[loc]);
      float b = blue (video.pixels[loc]);

      // Calculate an amount to change brightness based on the brightestPixel.x location 
      float adjustBrightness = map(brightestPixel.x, 0, width, 0, 20);      
      r *= adjustBrightness;
      g *= adjustBrightness;
      b *= adjustBrightness;

      // Constrain RGB values to make sure they are within 0-255 color range      
      r = constrain(r, 0, 255); 
      g = constrain(g, 0, 255);
      b = constrain(b, 0, 255);

      // Make a new color and set pixel in the window
      color c = color(r, g, b);
      pixels[loc] = c;
    }
  }

  // Apply changes
  updatePixels();
}