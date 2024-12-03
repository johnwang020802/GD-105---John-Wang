class Turtle {
  PVector pos;
  PVector heading;

  // Constructor
  Turtle(float x, float y) {
    pos = new PVector(x, y);
    heading = new PVector(1, 0); // Initial heading to the right (1, 0)
  }

//Changes the direction the turtle is facing by rotating its heading vector by a specified angle.
  void turn(float turnAmt) {
    heading.rotate(radians(turnAmt));
  }

//Moves the turtle forward by a specified distance in its current direction and draws a line representing its path
  void forward(float amount) {
    PVector oldPos = pos.copy(); 
    pos.add(PVector.mult(heading, amount));
    line (oldPos.x, oldPos.y, pos.x, pos.y); 
  }

//Reposition the turtle instantly to specified coordinates (x, y)
  void teleport(float x, float y) {
    pos.set(x, y);
  }
 
 //reset the default location
  void teleport() {
    // Optionally set a default teleport function
  }

//Return current position of turtle
  PVector getPosition() {
    return pos.copy();
  }

}

//FlyingTurtle class inherited from turtle class
//which includes the isFlying boolean property and the lineColor property.
  class FlyingTurtle extends Turtle {
   boolean isFlying;   
   color lineColor;

  // Constructor, Initializes the FlyingTurtle with a starting position (x, y) and a specified line color c. 
  //The isFlying property is set to false by default.
  FlyingTurtle(float x, float y, color c) { 
    super(x, y); 
    isFlying = false; 
    lineColor = c; 
  } 
 
 @Override 
 //@Override annotation, gnals to the compiler and developers that this method overrides 
 //the forward(float amount) method from the Turtle superclass
 //Checks if isFlying is false before drawing the line, If isFlying is true, the turtle moves forward without drawing a line.
 void forward(float amount) { 
    if (!isFlying) { 
     stroke(lineColor); // Set the stroke color 
     PVector oldPos = pos.copy(); 
     pos.add(PVector.mult(heading, amount)); 
     line(oldPos.x, oldPos.y, pos.x, pos.y); 
   } else { 
      pos.add(PVector.mult(heading, amount)); 
   } 
 
 }  

}

//Turtle t;
FlyingTurtle ft; 

//ArrayList<PVector> path = new ArrayList<PVector>(); // To store the path

void setup() {
  size(600, 800);
  background(255);

  // Initialize the turtle at the center of the canvas
// t = new Turtle(width / 2, height / 2);


 // Initialize the turtle at the center of the canvas with blue color  
  ft = new FlyingTurtle(width / 2, height / 2,  color(0, 0, 255));  
}

void draw() {
 
  
  ft.forward(10); 
  ft.turn(5); 
  
  //move forward alternatively with isFlying true or false 
   ft.isFlying = true; 
   ft.forward(10); 
    ft.turn(5); 
    
   ft.isFlying = false; 
   ft.forward(10); 
   ft.turn(5); 
   
}
