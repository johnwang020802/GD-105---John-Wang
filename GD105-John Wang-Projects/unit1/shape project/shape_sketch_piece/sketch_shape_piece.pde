PShape shape;

void setup()
{
  //Setup canvas size with 3D render
  size(666, 666, P3D); 
  
  //To initialize a PShape which can be any shape, 
  shape = createShape();
  
  //To create a square shape
  shape.beginShape(); 
  shape.strokeWeight(2);
  shape.fill(#ff0000);
  shape.vertex(-80, -80);
  shape.vertex(80, -80);
  shape.vertex(80, 80);
  shape.vertex(-80, 80);
  
  //To end the shape
  shape.endShape(CLOSE); 
  
}
void draw()
{
  
  //Setup the parameters used below
  float a,b,c;
  a = width;
  b = a/4;
  c=a*3/4;
 
  //Setup the background style
  background(180);
  stroke(#0000ff, 150);
  strokeWeight(5);
  fill(#ff0000);

  //Draw first group of circles
  circle (b, 444, 100);
  circle (b, 222, 100);
  
  //Draw first group of lines
  line (b - 50, 444, b - 50, 222);
  line (b + 50, 444, b + 50, 222);
  
  //Saves the current coordinate system to the stack
  pushMatrix();
  
  //Moves the drawing canvas in center of original cavas
  translate(a / 2, a / 2, 0);
  
  //Rotates around the x axis and y axis the given amount in radians.
  rotateX(frameCount * 0.01);
  rotateY(frameCount * 0.01);
  
  //draw the square
  shape(shape);
   
  //restores the prior coordinates 
  popMatrix();
  
  //Draw second group of circles  
  circle (c, 444, 100);
  circle (c, 222, 100);
  
  //Draw second group of lines
  line (c - 50, 444, c - 50, 222);
  line (c + 50, 444, c + 50, 222);
  
  
}
