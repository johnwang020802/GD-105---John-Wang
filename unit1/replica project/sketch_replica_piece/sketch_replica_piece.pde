 void setup()
{
  //Setup the carvas size exactly the image by pixel level
  size(264, 342);
}
void draw()
{
  //Setup backgroud style
  background(#ffffff);
  noStroke();
 
  //Draw first triangle in the first line 
  fill(#58d68d);
  triangle(0, 84, 44, 84, 44, 126);
  
  //Draw second triangle in the first line 
  fill(#47b876);
  triangle(44, 84, 44, 126, 88, 126);
  
  ///Draw third triangle in the first line 
  fill(#229954);
  triangle(176, 84, 220, 84, 220, 126);
  
  //Draw fourth triangle in the first line
 fill(#58d68d); 
 triangle(220, 84, 220, 126, 264, 126);
 

  //Draw first triangle in the second line
  fill(#FF0000);
  triangle(0, 126, 0, 168, 44, 126);
  
  //Draw second triangle in the second line
  fill(#000000);
  triangle(44, 126, 44, 168, 88, 126); 
  
  //Draw third triangle in the second line
  fill(#FF0000);
  triangle(88, 126, 88, 168, 132, 168);
  
  //Draw fourth triangle in the second line
  fill(#000000);
  triangle(132, 126, 132, 168, 176, 168);
  
  //Draw five triangle in the second line
  fill(#FF0000);
  triangle(176, 126, 178, 168, 220, 126);
  
   //Draw sixth triangle in the second line
  fill(#808080);
  triangle(220, 126, 220, 168, 264, 126);
 
  //Saves the current coordinate system to the stack
  pushMatrix();
  
  //Moves the drawing canvas in new location
  translate((width/2)+132, height/2);
  
  //rotates the object by 180 degrees
  rotate(TAU * (1.0/2.0));
  
  //Draw first triangle in the first line
  fill(#58d68d);
  triangle(0, 84, 44, 84, 44, 126);
  
  //Draw second triangle in the first line
  fill(#47b876);
  triangle(44, 84, 44, 126, 88, 126);
  
  //Draw third triangle in the first line
  fill(#229954);
  triangle(176, 84, 220, 84, 220, 126);
  
 //Draw fourth triangle in the first line
 fill(#58d68d); 
 triangle(220, 84, 220, 126, 264, 126);

  //Draw first triangle in the second line
  fill(#FF0000);
  triangle(0, 126, 0, 168, 44, 126);
  
  //Draw second triangle in the second line
  fill(#000000);
  triangle(44, 126, 44, 168, 88, 126); 
  
  //Draw third triangle in the second line
  fill(#FF0000);
  triangle(88, 126, 88, 168, 132, 168);
  
  //Draw fourth triangle in the second line
  fill(#000000);
  triangle(132, 126, 132, 168, 176, 168);
  
 //Draw five triangle in the second line
  fill(#FF0000);
  triangle(176, 126, 178, 168, 220, 126);
  
  //Draw sixth triangle in the second line
  fill(#808080);
  triangle(220, 126, 220, 168, 264, 126);
  
  //Restores the prior coordinates
  popMatrix();
  
}
