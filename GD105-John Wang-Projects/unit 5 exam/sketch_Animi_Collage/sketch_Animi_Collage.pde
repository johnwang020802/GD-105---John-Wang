import gifAnimation.*;

AnimImage face; 
AnimImage flesh;
AnimImage mouth;  

GifMaker gifExport;
int currentFrame = 0; 
int maxFrames;


void setup() {
    size(800, 600);
    
    imageMode(CENTER);  
    
     // Determine LCM of frames 
    maxFrames = lcm(4, lcm(3, 1));
    
    flesh = new AnimImage("flesh", 4, maxFrames); // Assuming 4 frames at 12 fps
    mouth = new AnimImage("mouth", 3, maxFrames); // Assuming 3 frames at 12 fps
    face = new AnimImage("face", 1, 0); // Assuming 1 frame 
  
     
   gifExport = new GifMaker(this, "animated_collage.gif"); 
   gifExport.setRepeat(0); // Loop forever 
   gifExport.setQuality(10); // Set GIF quality 
   frameRate(maxFrames); 
    
}

void draw() {
    background(255);   
    
   flesh.display(width/2, height/2, true);
   face.display(width/2, height/2, false);
   mouth.display(width/2, height/2, true);
  
   
   
   if (frameCount < maxFrames) { 
     gifExport.addFrame(); 
     frameCount++; 
   } else { 
     gifExport.finish(); 
     noLoop(); 
  }  
   
}
   
  int lcm(int a, int b) { 
      return a * (b / gcd(a, b)); 
   }
    
 int gcd(int a, int b) { 
      while (b != 0) { 
        int t = b; 
        b = a % b; 
        a = t; 
     }
     return a;
   }
    


class AnimImage {
    PImage[] frames;
    PImage image; 
    int totalFrames;
    int currentFrame;
    int frameRate;

    AnimImage(String imageName, int frameCount, int frameRate) {
        this.totalFrames = frameCount;
        this.frameRate = frameRate;
        this.frames = new PImage[totalFrames];
        this.currentFrame = 0;
        
        // Load images from the specified folder
        if (frameCount > 1) {
           for (int i = 0; i < totalFrames; i++) {
              String imageNameT =imageName+ i + ".png"; 
              println("image name" + imageNameT);
              frames[i] = loadImage(imageNameT);
              
           }
        }  else {
          println("image name" + imageName);  
          image = loadImage(imageName+ ".png"); 
        }
    }

  
    void display(int x, int y, boolean frameset) {
        if (frameset == true) {
          image(frames[frameCount%frames.length], x, y);
        } else {
          image(image, x, y); 
        }
     }
}
