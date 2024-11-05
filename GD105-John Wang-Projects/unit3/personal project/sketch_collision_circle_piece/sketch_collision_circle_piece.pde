class Sphere {
  float x, y, z, radius, dx, dy, dz;
  color col;
  color[] colors;
  int currentColorIndex;

 //contructor to build the sphare with right color
 Sphere(float x, float y, float z, float radius, color[] colors) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.radius = radius;
    this.dx = random(-2, 2); // Random speed on the x-axis
    this.dy = random(-2, 2); // Random speed on the y-axis
    this.dz = random(-2, 2); // Random speed on the z-axis
    this.colors = colors;
    this.currentColorIndex = 0;
    this.col = colors[currentColorIndex];
  }
  
 //Define the move function of sphare which can change in x, y and z directions
 //also can bounce back from the edges
  void move() {
    x += dx;
    y += dy;
    z += dz;

    // Bounce off the edges
    if (x < radius || x > width - radius) dx *= -1;
    if (y < radius || y > height - radius) dy *= -1;
    if (z < -500 || z > 500) dz *= -1;
  }

 //Define two sphare if collide or not. 
  boolean isColliding(Sphere other) {
    float distance = dist(this.x, this.y, this.z, other.x, other.y, other.z);
    return distance < (this.radius + other.radius);
  }

 //Define how sphare should display
  void display() {
    fill(col);
    pushMatrix();
    translate(x, y, z);
    sphere(radius);
    popMatrix();
  }

 //Check if two sphares are collided or not.  
  void checkCollisions(Sphere[] spheres) {
    for (int i = 0; i < spheres.length; i++) {
      Sphere other = spheres[i];
      if (this != other && isColliding(other)) {
        currentColorIndex = (currentColorIndex + 1) % colors.length;
        col = colors[currentColorIndex];
      }
    }
  }
}

//Intialize the spahres array and color palette array
Sphere[] spheres;
color[] colorPalette1 = {color(255, 0, 0), color(0, 255, 0)};
color[] colorPalette2 = {color(0, 0, 255), color(255, 255, 0)};
color[] colorPalette3 = {color(255, 0, 255), color(0, 255, 255)};
color[] colorPalette4 = {color(255, 165, 0), color(75, 0, 130)};

void setup() {
  size(800, 800, P3D);
  noStroke();
  lights();
 // translate(232, 192, 0);
  spheres = new Sphere[20]; // Array of 20 sphares

  // Initialize spheres and make sure all spheres not stick in the wall. 
  for (int i = 0; i < spheres.length; i++) {
    float x = random(width);
    if (x <30 || X> width) {
      x = random(width); 
     }
     
    float y = random(height); 
    if (y<30 || Y>height) {
       y = random(height);
    }
    
   //intialize the spheres with diferent colors. 
   if (i < 5) spheres[i] = new Sphere(x, y, random(-500, 500), random(20, 40), colorPalette1); 
    else if (i < 10) spheres[i] = new Sphere(x, y, random(-500, 500), random(20, 40), colorPalette2);
    else if (i < 15) spheres[i] = new Sphere(x, y, random(-500, 500), random(20, 40), colorPalette3);
    else spheres[i] = new Sphere(x, y, random(-500, 500), random(20, 40), colorPalette4);
  }
}

void draw() {
  background(255);
  for (int i = 0; i < spheres.length; i++) {
    spheres[i].move();
    spheres[i].checkCollisions(spheres);
    spheres[i].display();
  }
  
  //  //Save 300 frames inside frame holder 
  //if(frameCount<300) {
  //  saveFrame("frames/ellipse-######.png");
  //}
}
