PFont yeppers;
void setup()
{
  size(400,400);
  background(#00FF12);
  yeppers = loadFont("ShowcardGothic-Reg-48.vlw");
  textFont(yeppers);
  textSize(50);
}
void draw()
{
  text("Extreme", 80,190);
  fill(#FF0000);
  text("VIOLENCE", 80,240);
}
