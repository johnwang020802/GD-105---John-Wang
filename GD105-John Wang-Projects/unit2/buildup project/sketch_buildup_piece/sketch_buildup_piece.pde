float angle = 0.0; //Start point of the angle
float radius = 100.0; //Start point of the radius
float angleChange = 0.05; //Angle change offset
float radiusChange = 0.5;  //Radius change offset


void setup() {
  
  //Setup the background style
  size(600, 600);
  background(255);
}

void draw() {
 
  //Shifts the origin point of the draw to the center of the window
  translate(width/2, height/2);
  
 //Set stroke color to black without fill any color
  stroke(0);
  noFill();
  
 // Calculates the x-coordinate and y-coordinate in circle motion and it shifts the radius outward by 100 units
  float x = cos(angle) * (radius + 100);
  float y = sin(angle) * (radius + 100);
    
   //Draw the eclipse
   ellipse(x, y, 50, 50);
    
   //Keep increasing the angle and radius
    angle += angleChange;
    radius += radiusChange;


 if (radius > 200 || radius < 50) {
    radiusChange = -radiusChange; // Reverse the direction of radius change
  }
  
  if(frameCount<300) {
  saveFrame("frames/ellipse-######.png");
  }
  
}
