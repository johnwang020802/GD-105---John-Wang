PShape stemSH;
 
 void setup()
{
  //Setup canvas size with high quality 2D render
  size(1000,1000,P2D);
  
   //To initialize a PShape which can be any shape, 
  stemSH = createShape();
  
  //To create a square shape
  stemSH.beginShape(); 
  stemSH.strokeWeight(2);
  stemSH.fill(#187e33);
  stemSH.vertex(450, 200);
  stemSH.vertex(550, 200);
  stemSH.vertex(450, 300);
  stemSH.vertex(550, 300);
  
  //To end the shape
  stemSH.endShape(CLOSE); 
  
  
}
void draw()
{
  //Setup backgroup style
  background(#ffffff);
  fill(#00FF00);
  ellipseMode(CENTER);
  stroke(ROUND);
  stroke(#174129);
  strokeWeight(3);
  
  //Setup the vector at center of canvas
  PVector center = new PVector(width / 2, height / 2);
 
  //Draw the stem
  shape(stemSH);
  
  //Draw the body
  ellipse(center.x, center.y, 800, 500);
 
  //Draw the mouth
  fill(#FF0000);
  triangle(center.x, center.y + 150, center.x - 100, center.y + 50, center.x + 100,center.y + 50);
  
  //Draw the left eye
  line(center.x - 100,center.y - 50, center.x - 300, center.y - 150);
  line(center.x - 100,center.y - 50, center.x - 300, center.y);
 
  //Draw the right eye
  line(center.x + 100,center.y - 50, center.x + 300, center.y - 150);
  line(center.x + 100,center.y - 50, center.x + 300, center.y);
 
  //Draw first leave
  fill(#246840);
  translate(center.x, center.y - 300);
  ellipse(-200, 0 ,400,100);
  
  //Draw second leave rotated 180 degree
  pushMatrix();
  rotate(TAU * (1.0/2.0));
  ellipse(-200, 0 ,400,100);
  popMatrix();
  
}
