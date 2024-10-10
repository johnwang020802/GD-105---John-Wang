float x = 0.5; //Initial X position
float y = 0.5; //Initial y position
float circleSize = 50;  //Initial circle size

void setup() {
  
  //Setup backgroud style
  size(800, 800);
  background(255);
}

void draw() {
  
  ////Reset to a white background at the start of every frame
  background(255);
 
  //Changing circle size based on inputs
  circleSize = map(x * Y, 0, 1, 10, 200);
 
  //Draw the circle 
  fill(100, 150, 255);
  ellipse(mapingXYControl(x, width), mapingXYControl(y, height), circleSize, circleSize);
 
   // Update X and Y over time to animate
  x += 0.01;
  y += 0.01;

  // Keep X and Y within range [0, 1]
  if (x > 1) x = 0;
  if (y > 1) y = 0;
  
  //Save 300 frames inside frame holder 
  if(frameCount<300) {
    saveFrame("frames/ellipse-######.png");
  }
}

//Function used to mapping inputs to screen size
float mapingXYControl(float value, int size) {
    return map(value, 0, 1, 0, size);
 }
 
