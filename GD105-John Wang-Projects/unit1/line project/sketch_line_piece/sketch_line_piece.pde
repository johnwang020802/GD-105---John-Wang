PVector v1, v2;

void setup() 
{
  //Setup canvas size with high quality to render stroke
  size (400, 400, P2D); 
  
  //Set backgroud color to white
  background(255);
 
  //Sets the width of the stroke
  strokeWeight (25); 
  
  //Sets the style for rendering line endings to square
  strokeCap (SQUARE);
    
  //Setup the vectors for X- coordinate and Y-coordinate
  v1 = new PVector(50, 100);
  v2 = new PVector(250, 100);
}

void draw()
{  
  
  //All line will be rotated in 30 degrees. 
  float angle = PI / 6; 
  
  //Set strock color to blue
  stroke (0, 0, 255);
  
 
  //Line 1 in horizontal direction 
  line (v1.x, v1.y-10, v2.x, (v2.y-10)*tan(angle));
  
  //line 2 in horizontal direction 
  line (v1.x+70, v1.y+30, v2.x+100, (v2.y+50)*tan(angle));
  
  //line 3 in horizontal direction
  line (v1.x+95, v1.y+80, width, (v2.y+130)*tan(angle));
  
  //line 4 in horizontal direction
  line (v1.x+90, v1.y+135, width, (v2.y+225)*tan(angle));
  
  //line 1 in vertical direction
  line (v1.x, v1.y-50, (v2.x-207)/tan(angle), (v2.y+50));
  
  //line 2 in vertical direction
  line (v1.x+50, v1.y-75, (v2.x-150)/tan(angle), (v2.y+250));
  
  //line 3 in vertical direction
  line (v1.x+122, v1.y-20, (v2.x-110)/tan(angle), height);
  
  //line 4 in vertical direction
  line (v1.x+190, v1.y+15, (v2.x-74)/tan(angle), height);
  
  //line 5 in in vertical direction
  line (v1.x+246, v1.x+50, (v2.x-40)/tan(angle), height);
  
  //line 6 in vertical direction
  line (v1.x+324, v1.y+100, (v2.x-22)/tan(angle),(v2.y+200));

} 
