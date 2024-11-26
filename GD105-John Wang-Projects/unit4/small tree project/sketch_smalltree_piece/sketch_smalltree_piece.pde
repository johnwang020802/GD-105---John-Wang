ArrayList<Tree> trees;
Table treeTable;
int startRow = 0; // Start row for scrolling 
int rowsToShow = 10; // Number of rows to show at a time 
int totalRows; // Total number of rows in the table
boolean displayTable = true; // Flag to track table display
String treeName = "Silver Maple";
float growthRate = 0.15; 
float maxGrowthStage = 250;



void setup() {
  size(800, 600);
  //Initiaze the tree array
  trees = new ArrayList<Tree>();
  
  //load the dataset data of tree facts. 
  treeTable = loadTable("tree_data.csv", "header");
  totalRows = treeTable.getRowCount();
  
}

void draw() {
  background(135, 206, 235); // Sky blue background
  
  // Draw the ground
  fill(34, 139, 34); // Green for the ground
  rect(0, height - 100, width, 100);
  
  fill(0); 
  textAlign(CENTER, CENTER);
  textSize(30);
  text(treeName, 400, 550); 
    
  
  // Update and display all trees
  for (Tree tree : trees) {
    tree.grow();
    tree.display();
  }
 
  
  
// Display the table if the flag is true 
if (displayTable) { 
    displayTreeTable(); 
 }
 
  //  //Save 300 frames inside frame holder 
  //if(frameCount> 50 && frameCount<700) {
  //  saveFrame("frames/tree-######.png");
  //}
  
}

void mousePressed() {
  
  // Toggle the displayTable flag when the screen is clicked 
   displayTable = !displayTable;
   
   
  // Ensure seed is dropped on the ground
  if (mouseY > height - 100) {
    trees.add(new Tree(mouseX, mouseY));
  }
  
   
}

void keyPressed() {
  if (key == 'r' || key == 'R') { 
      for (Tree tree : trees) { 
         tree.clean(); // Reset the tree when 'r' is pressed 
       } 
      
   int randomRow = int(random(1, 30));
  TableRow row = treeTable.getRow(randomRow);
  treeName = row.getString("Name"); 
  
  fill(0); 
  textAlign(CENTER, CENTER);
  textSize(30);
  text(treeName, 400, 550); ; 
  
  
  String growRateString= row.getString("GrowthRate"); 
  String matureSizeString = row.getString("MatureSize"); 
  
 println(""+ treeName +" " + growRateString + " "  +  matureSizeString); 
  int growRateInt = int(growRateString.substring(0,1)); 
  
   println("int of growRate" + growRateInt); 
   if (growRateInt == 1 ) {
        growthRate = 0.1; 
   } else if ( growRateInt  == 2 ) {
        growthRate = 0.2;
   }  else  {
        growthRate = 0.3;
     } 
     
   int matureSizInt= int(matureSizeString.substring(0, 2)); 
    println("int of mature size " + matureSizInt); 
   
     if (matureSizInt < 50 )  {
         maxGrowthStage = 200; 
     } else if (matureSizInt > 50 && matureSizInt < 60 ) { 
         maxGrowthStage = 250;
    }  else {
        maxGrowthStage = 300;
    }
  } 
  
  println(""+ treeName +" " + growthRate + " "  +  maxGrowthStage);
  
}

//class tree represent the tree properties and functions which can grow and display
class Tree {
  PVector position;
  float growthStage;
  //float maxGrowthStage = 300; // Adjust to control tree growth stages
  //float growthRate = 0.1; // Slow growth rate
  ArrayList<Branch> branches;
  color trunkColor = color(139, 69, 19); // Saddle brown for the trunk
  
  //Constructor of the tree and add more branch. 
  Tree(float x, float y) {
    position = new PVector(x, y);
    growthStage = 0;
    branches = new ArrayList<Branch>();
    branches.add(new Branch(new PVector(x, y), new PVector(0, -10), trunkColor, 10, 1, 20)); // Start with one main branch, set for small tree
  }
  
  void grow() {
    
     println(""+ treeName +" " + growthRate + " "  +  maxGrowthStage);
     
    if (growthStage < maxGrowthStage) {
      growthStage += growthRate; // Gradual growth
      ArrayList<Branch> newBranches = new ArrayList<Branch>();
      for (Branch branch : branches) {
        branch.grow();
        if (branch.readyToBranch && branch.length >= branch.maxLength) { // Add new branches periodically
          PVector newDir1 = branch.direction.copy().rotate(PI / 6);
          PVector newDir2 = branch.direction.copy().rotate(-PI / 6);
          newBranches.add(new Branch(branch.end.copy(), newDir1, branch.branchColor, branch.thickness * 0.7, branch.depth + 1, branch.maxLength * 0.6));
          newBranches.add(new Branch(branch.end.copy(), newDir2, branch.branchColor, branch.thickness * 0.7, branch.depth + 1, branch.maxLength * 0.6));
          branch.readyToBranch = false;
        }
      }
      branches.addAll(newBranches);
    }
  }
  
  void display() {
    for (Branch branch : branches) {
      branch.display();
    }
  }
 
 void clean() { 
   growthStage = 0; // Reset growth stage 
   branches.clear(); // Clear all existing branches 
   branches.add(new Branch(new PVector(position.x, position.y), new PVector(0, -10), trunkColor, 10, 1, 20)); // Add initial branch 
 }
}

//class branch represent the tree properties and functions which can grow, display and add more leaves
class Branch {
  PVector start;
  PVector end;
  PVector direction;
  color branchColor;
  float thickness;
  float length;
  float maxLength;
  boolean readyToBranch = true;
  boolean hasLeaves = false;
  int depth;
  
  Branch(PVector start, PVector direction, color branchColor, float thickness, int depth, float maxLength) {
    this.start = start;
    this.direction = direction;
    this.branchColor = branchColor;
    this.thickness = thickness;
    this.length = 0;
    this.end = start.copy();
    this.depth = depth;
    this.maxLength = maxLength;
  }
  
  void grow() {
    if (length < maxLength) {
      length += 0.1; // Slow branch growth rate
      end = PVector.add(start, PVector.mult(direction, length));
    }
    if (length >= maxLength) {
      hasLeaves = true; // Set hasLeaves to true when branch reaches maximum length
    }
  }
  
  void display() {
    stroke(branchColor);
    strokeWeight(thickness);
    line(start.x, start.y, end.x, end.y);
    
    // Draw leaves if the branch has grown to its maximum length
    if (hasLeaves) {
      fill(34, 139, 34); // Green color for leaves
      noStroke();
      ellipse(end.x, end.y, 10, 10); // Draw a simple leaf as an ellipse

      // Add more leaves to simulate fuller foliage
      for (int i = 0; i < 3; i++) {
        float angle = random(TWO_PI);
        float distance = random(5, 15);
        float x = end.x + cos(angle) * distance;
        float y = end.y + sin(angle) * distance;
        ellipse(x, y, 10, 10);
      }
    }
  }
}

//display tree fact data 
void displayTreeTable() {
 // background(255);
  fill(0);
  
  // Display column headers
  textAlign(CENTER, CENTER);
  textSize(16);
  text("Id", 50, 100);
  text("Name", 100, 100);
  text("Growth Rate", 280,100);
  text("Mature Size", 400, 100);
  text("Root Depth", 550, 100);
  
  // Display rows
  textSize(14);
  int rowHeight = 30;
  
  //Only display certains rows of the table
  for (int i = startRow; i < min(startRow + rowsToShow, totalRows); i++) { 
    TableRow row = treeTable.getRow(i); 
    textAlign(LEFT, CENTER); 
    textAlign(LEFT, CENTER);
    text(row.getString("Id"), 50, 130 + (i - startRow) * rowHeight);
    text(row.getString("Name"), 100, 130 + (i - startRow) * rowHeight); 
     textAlign(CENTER, CENTER); text(row.getString("GrowthRate"), 280, 130 + (i - startRow) * rowHeight); 
     text(row.getString("MatureSize"), 400,130 + (i - startRow) * rowHeight); 
     text(row.getString("RootDepth"), 550, 130 + (i - startRow) * rowHeight);  
   }
}

//With mouse scroll, tabel raws can be changed. 
void mouseWheel(MouseEvent event) { 
 float e = event.getCount(); 
  if (e > 0 && startRow + rowsToShow < totalRows) { 
   startRow++; 
 } else if (e < 0 && startRow > 0) { 
  startRow--; 
 } 
 displayTreeTable();
}
  
  
