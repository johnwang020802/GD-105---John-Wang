ArrayList<Firework> fireworks;

void setup() {
  size(800, 600);
  fireworks = new ArrayList<Firework>();
}

void draw() {
  background(0);
  
  // Launch new fireworks at random intervals
  if (random(1) < 0.05) {
    fireworks.add(new Firework());
  }
  
  // Update and display all fireworks
  for (int i = fireworks.size() - 1; i >= 0; i--) {
    Firework f = fireworks.get(i);
    f.update();
    f.display();
    if (f.isDone()) {
      fireworks.remove(i);
    }
  }
  
//    //Save 300 frames inside frame holder 
//  if(frameCount> 50 && frameCount<350) {
//    saveFrame("frames/fireworks-######.png");
//  }
}

class Firework {
  Particle firework;
  ArrayList<Particle> particles;
  boolean exploded;
  
 //Constructor is initializing an instance of the Firework class
  Firework() {
    firework = new Particle(new PVector(random(width), height),  // Start position: random horizontal position at the bottom of the screen
      new PVector(0, random(-10, -5)),  // Initial velocity: upwards with random speed
       color(random(255), random(255),random(255)),  //random colors
       6,     //Size of the firework particle
       true);  // Boolean indicating it's the main firework particle
       
    // Initialize the list of particles that represent the exploded piece
    particles = new ArrayList<Particle>();
    
    // Flag to indicate whether the firework has exploded
    exploded = false;
  }
  
  void update() {
    if (!exploded) {
      
      //Applies a gravitational force to the main firework particle, pulling it downwards.
      firework.applyForce(new PVector(0, 0.1)); 
      
      //Updates the position and state of the main firework particle based on its velocity and the applied forces.
      firework.update();
      
      //checks if the firework's vertical velocity has reached its peak height and is starting to fall back down).
      if (firework.velocity.y >= 0) {
        exploded = true;  //Sets the exploded flag to true, indicating that the firework has exploded.
        explode(); //Calls the explode method to create smaller particles representing the explosion.
      }
    }
    
    //Update and Remove Exploded Particles:
    for (int i = particles.size() - 1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.applyForce(new PVector(0, 0.1)); // Gravity
      p.update();
      if (p.isDone()) {
        particles.remove(i);
      }
    }
  }
  
  void explode() {
    // Different shapes: Circle, Heart, Star
    int shapeType = int(random(3));
    
    if (shapeType == 0) {
      // Circle
      for (int i = 0; i < 100; i++) {
        PVector position = firework.position.copy();
        PVector velocity = PVector.fromAngle(TWO_PI * i / 100);
        velocity.mult(random(2, 10));
        particles.add(new Particle(position, velocity, firework.col, 12, false));
      }
    } else if (shapeType == 1) {
      // Heart
      for (float t = 0; t < TWO_PI; t += 0.1) {
        PVector position = firework.position.copy();
        float x = 16 * pow(sin(t), 3);
        float y = -(13 * cos(t) - 5 * cos(2 * t) - 2 * cos(3 * t) - cos(4 * t));
        PVector velocity = new PVector(x, y);
        velocity.mult(0.5);
        particles.add(new Particle(position, velocity, firework.col, 12, false));
      }
    } else if (shapeType == 2) {
      // Star
      for (int i = 0; i < 30; i++) {
        float angle = TWO_PI * i / 5;
        for (int j = 0; j < 10; j++) {
          PVector position = firework.position.copy();
          PVector velocity = PVector.fromAngle(angle + TWO_PI * j / 50);
          velocity.mult(random(2, 10));
          particles.add(new Particle(position, velocity, firework.col, 12, false));
        }
      }
    }else if (shapeType == 3) { 
      // Flower 
     for (int i = 0; i < 100; i++) { 
      PVector position = firework.position.copy(); 
      float angle = TWO_PI * i / 100; 
      float radius = cos(4 * angle) * 10 + 15; 
      PVector velocity = new PVector(radius * cos(angle), radius * sin(angle)); 
      particles.add(new Particle(position, velocity, firework.col, 12, false)); 
     } 
   }
  }
  
 //The visual representation of the firework and its exploded particles.
  void display() {
   //Checks if the firework has not yet exploded.
    if (!exploded) {
      firework.display();
    }
  
  //Display Exploded Particles
    for (Particle p : particles) {
      p.display();
    }
  }
 
  //Check if a Firework object is finished. It returns true if both conditions are met: 
  //the firework has exploded, and all the particles resulting from the explosion are gone.
  boolean isDone() {
    return exploded && particles.isEmpty();
  }
}

//Basic particle class used for firework 
class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  color col;
  float lifespan;
  float size;
  boolean firework;

  Particle(PVector position, PVector velocity, color col, float size, boolean firework) {
    this.position = position.copy();
    this.velocity = velocity.copy();
    this.acceleration = new PVector();
    this.col = col;
    this.size = size;
    this.firework = firework;
    this.lifespan = 255;  // Initializes the lifespan of a firework to its maximum value
  }

  //Adds a given force to the object's acceleration, like gravity
  void applyForce(PVector force) {
    acceleration.add(force);
  }

//Update the state of an object, specifically its position, velocity, and other properties over time
  void update() {
    velocity.add(acceleration);
    position.add(velocity);
   
   //Clears the acceleration for the next frame.
    acceleration.mult(0);
   
    //Decreases the lifespan of the object if it is not a firework.
    if (!firework) {
      lifespan -= 4;
    }
  }

//Displays the particle on the screen with its current properties.
  void display() {
    if (!firework) {
      stroke(col, lifespan);
      strokeWeight(size);
    } else {
      stroke(col);
      strokeWeight(size);
    }
    point(position.x, position.y);
  }

//Checks if the particle's lifespan has ended
  boolean isDone() {
    return lifespan < 0;
  }
}
