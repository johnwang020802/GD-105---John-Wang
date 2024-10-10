import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

//Define the minim and audioInput
Minim minim;
AudioInput in;

float circleSize = 50; //Initial circle size

void setup()
{
  //Setup backgroud style
  size(800, 800);
  //Initial minim and used sound as input
  minim = new Minim(this);
  in = minim.getLineIn(Minim.STEREO, 512);
  background(255);
}

void draw()
{
  background(255);

  // Changing circle size based on audio input
  circleSize = map((mapingXYControl(in.left.level(), width/2) * mapingXYControl(in.right.level(), height/2))/1000, 0, 1, 10, 200);
 
  //Draw the circle 
  fill(100, 150, 255);
  ellipse(mapingXYControl(in.left.level(), width/2), mapingXYControl(in.right.level(), height/2), circleSize, circleSize);
 
}

//function used to mapping inputs to screen size
float mapingXYControl(float value, int size) {
  return map(value, 0, 1, 0, size);
}
