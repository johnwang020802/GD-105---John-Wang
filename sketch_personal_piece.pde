 void setup()
{
  size(1000,1000);
}
void draw()
{
  background(#ffffff);
  fill(#00FF00);
  ellipseMode(CENTER);
  stroke(ROUND);
  PVector center = new PVector(width / 2, height / 2);
 
  //body
  ellipse(center.x, center.y, 800, 500);
 
  //mouth
  fill(#FF0000);
  triangle(center.x, center.y + 150, center.x - 100, center.y + 50, center.x + 100,center.y + 50);
  
  //left eye
  line(center.x - 100,center.y - 50, center.x - 300, center.y - 150);
  line(center.x - 100,center.y - 50, center.x - 300, center.y);
 
  //right eye
  line(center.x + 100,center.y - 50, center.x + 300, center.y - 150);
  line(center.x + 100,center.y - 50, center.x + 300, center.y);

  //stem
  line(center.x + 50, center.y - 200, center.x + 50, center.y - 300);
  line(center.x - 50, center.y - 200, center.x - 50, center.y - 300);

  //leaves
  fill(#013220);
  translate(center.x, center.y - 300);
  ellipse(-200, 0 ,400,100);
  pushMatrix();
  rotate(TAU * (1.0/2.0));
  ellipse(-200, 0 ,400,100);
  popMatrix();

  
  
}
