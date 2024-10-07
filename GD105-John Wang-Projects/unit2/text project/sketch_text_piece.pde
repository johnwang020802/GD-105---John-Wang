PFont yeppers;
void setup()
{
  //Setup canvas size 
  size(400,400);
  
  //setup the backgroup color
  background(#00FF12);
  
  //Load redefined font style
  yeppers = loadFont("ShowcardGothic-Reg-48.vlw");
  
  //Setup the fond style
  textFont(yeppers);
  textSize(50);
}
void draw()
{
  //Draw the text in first line
  text("Extreme", 80,190);
  
  //Fill text color 
  fill(#FF0000);
  
  //Draw the text in first line
  text("VIOLENCE", 80,240);
}
