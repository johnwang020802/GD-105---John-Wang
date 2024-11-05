int numLines =666; 
float spacing;
color color1, color2, color3, color4, color5, color6;  
float angle = 0;

void setup() {
 
  //Setup default style, and two set of colors for lines
  size(900, 900);
  color1 = color(255, 0, 0);
  color2 = color(0, 0, 255); 
  color3 = color(255, 0, 255);
  color4 = color(255, 255, 0);
  color5 = color(255, 165, 0); 
  color6 = color(150, 0, 255); 
  
  background(color3);
  spacing = width / float(numLines);
}

void draw() {
  
  background(color3);
  strokeWeight(1);
  angle += 0.01; // Increment angle for animation

  //Generate 666 lines for vertical and horizontal lines
  for (int i = 0; i < numLines; i++) {
    float x = i * spacing;
    
    //Generates a smooth, oscillating value using the sine function and also creating a wave-like pattern, 
    //adds a bit of randomness to the offset using Perlin noise. 
    float offset = sin(angle + radians(i * 2)) * 50 + noise(i * 0.1) * 50; 
    
      stroke((i % 2 == 0) ? color1 : color2); 
      line(x + offset, 0, x - offset, height); // Vertical lines with offset
    
     stroke((i % 2 == 0) ? color5 : color6);
     line(0, x + offset, width, x - offset); // Horizontal lines with offset    
  }
  
  // Adding Ben Day dots effect, draw from x-axis and then y-axis 
  for (int x = 0; x < width; x += 40) {
    for (int y = 0; y < height; y += 40) {
      
      stroke(color4);
      
      //The dot size that varies smoothly based on Perlin noise, making the size range from 2 to 8
      float dotSize = map(noise(x * 0.05, y * 0.05, angle * 0.1), 0, 1, 2, 8);
      
      //Draws an ellipse that oscillates around the point (x, y) in a circular motion with a radius of 5 pixels, 
      //and the size of the ellipse is defined by dotSize.
      ellipse(x + sin(angle) * 5, y + cos(angle) * 5, dotSize, dotSize);
    }
  }
  
  
  // //Save 300 frames inside frame holder 
  //if(frameCount> 50 && frameCount<350) {
  //  saveFrame("frames/ellipse-######.png");
  //}
}
