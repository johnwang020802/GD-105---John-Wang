float angle = PI / 4;  // Starting at 45 degrees
float angleVelocity = 0.0;
float angleAcceleration = 0.0;
float length = 280;  // Length of the pendulum
float gravity = 2;  // Acceleration due to gravity
float damping = 0.999;  // Damping factor to simulate friction

void setup() {
  size(800, 800);
  background(255);
}

void draw() {
  background(255);
  translate(width / 2, 100);  // Move the origin to the top-center of the window
  
  // Calculate the angular acceleration
  angleAcceleration = (-1 * gravity / length) * sin(angle);
  
  // Update the angular velocity and angle
  angleVelocity += angleAcceleration;
  angleVelocity *= damping;  // Apply damping
  angle += angleVelocity;
  
 // Reverse the direction at 45 degrees and -45 degrees
  if (angle > PI / 4 || angle < -PI / 4) {
    angleVelocity *= -1;
  }

  // Calculate the position of the pendulum bob
  float x = length * sin(angle);
  float y = length * cos(angle);
  
  // Draw the pendulum
  stroke(0);
 strokeWeight(3);
 line(0, 0, x, y);
 fill(#fff000);
 ellipse(x, y, 40, 40); 

//Save 300 frames inside frame holder 
 if(frameCount<300) {
    saveFrame("frames/ellipse-######.png");
 }
 
}
  
