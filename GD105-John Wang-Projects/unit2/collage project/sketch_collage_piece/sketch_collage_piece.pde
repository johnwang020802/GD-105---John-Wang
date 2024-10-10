//Declare all images
PImage jasper1, jasper2, jasper3, jasper4, jasper5, jasper6, fork1, fork2, fork3, fork4, karl, max1, max2, max3; 

void setup()
{
  //Setup backgroud size
  size(1024,1024);
  
  //Loads all images into a variable of type PImage
  jasper1 = loadImage ("Jasper 1.png");
  jasper2 = loadImage ("Jasper 2 stairs.png");  
  jasper3 = loadImage ("Jasper 3.png");
  jasper4 = loadImage ("Jasper 4.png");
  jasper5 = loadImage ("Jasper 5.png");
  jasper6 = loadImage ("Jasper 6.png");
  fork1 = loadImage ("Fork 1.png");
  fork2 = loadImage ("Fork 2.png");
  fork3 = loadImage ("Fork 3.png");
  fork4 = loadImage ("Fork 4.png");
  karl = loadImage ("Karl 1.png");
  max1 = loadImage ("Max 1.png");
  max2 = loadImage ("Max 2.png");
  max3 = loadImage ("Max 3.png");
  
  //Sets the image drawing mode to "center"
  imageMode(CENTER);

}
void draw()
{
  //Place jasper1
  placeImage(jasper1, 165, 215, 0, 0.75); 
 //Place jasper 2
  placeImage(jasper2, 165, 960, 0, 0.75); 
  //Place jasper 3
  placeImage(jasper3, 590, 215, 0, 1.5); 
  //Place jasper 4
  placeImage(jasper4, 1200, 1150, 0, 0.75); 
  //Place jasper 5
  placeImage(jasper5, 1900, 1200, 0, 0.5); 
  //Place jasper 6
  placeImage(jasper6, 250, 250, 0, 2); 
  //Place fork 1
  placeImage(fork1, 330, 300, 0, 1.5); 
  //place fork 2
  placeImage(fork2, 150, 600, 0, 1.75); 
  //Place fork 3
  placeImage(fork3, 450, 200, 0, 1.75); 
  //Place fork 4
  placeImage(fork4, 650, 500, 100, 1.25); 
  //place karl 
  placeImage(karl, 200, 350, 0, 1.25); 
  //Place max 1
  placeImage(max1, 200, 500, 0, 1.5); 
  //Place max 2 
  placeImage(max2, 630, 950, 0, 1); 
  //Place max 3
  placeImage(max3, 300, 150, 0, 1.75); 
}

//function used to draw the images with scale,  translate, and rotateability
void placeImage(PImage img, float translateX, float translateY, float rotation, float size)
{
  pushMatrix();  //Saves the current transformation matrix
  scale(size);   //Scales the image by the given size factor
  translate(translateX, translateY);   //Moves the image to the specified position.
  rotate(rotation);  //Rotates the image
  image(img,0,0);    //Draws the image
  popMatrix();   //Restores the transformation matrix
}
