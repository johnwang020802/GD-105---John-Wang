void setup()
{
  size(666, 666);
}
void draw()
{
  float a,b;
  a = width;
  b = a/2;

  background(180);
  stroke(#0000ff, 150);
  strokeWeight(5);
  fill(#ff0000);

  circle (b, 444, 100);
  circle (b, 222, 100);
  
  line (b - 50, 444, b - 50, 222);
  line (b + 50, 444, b + 50, 222);
  
  
}
