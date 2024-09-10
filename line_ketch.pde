void setup() 
{
  size (400, 400);
  strokeWeight (25);
  strokeCap (SQUARE);
}
void draw()
{  
  //horizontal line
  stroke (0, 0, 255);
  line (50, 100, 250, 100);
  
  //horizontal line 2
  line (100, 150, 350, 150);
  
  //horizontal line 3 
  line (100, 200, width, 200);
  
  //horizontal line 4
  line (150, 250, width, 250);
  
  //vertical line
  line (50, 50, 50, 250);
  
  //vertical line 2
  line (100, 25, 100, 350);
  
  //vertical line 3
  line (150, 100, 150, height);
  
  //vertical line 4
  line (200, 150, 200, height);
  
  //vertical line 5
  line (250, 200, 250, height);
  
  //vertical line 6
  line (300, 250, 300, height);

} 
