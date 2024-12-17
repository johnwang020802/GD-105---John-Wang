import java.util.HashMap;
import java.util.Random;
import java.util.ArrayList;
import java.util.Calendar; 
import java.util.Date; 
import java.util.GregorianCalendar;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.awt.Component;
import java.awt.Frame;

HashMap<String, Float> prices = new HashMap<String, Float>();
HashMap<String, ArrayList<Float>> priceHistory = new HashMap<String, ArrayList<Float>>();
HashMap<String, Integer> userInventory = new HashMap<String, Integer>();
String[] fruits = {"Apple", "Banana", "Cherry", "Grape", "Orange"};
Random random = new Random();
int selectedFruitIndex = -1;
int day = 0;
int playDays=0;
boolean transactionDone = false;
String message = "";
float balance = 100.0; // Starting balance
int lastMilestone = 0; // Track the last milestone reached
final float MIN_PRICE = 0.10;
final int SIMULATION_DAYS = 365; // Simulate one year
String viewMode = "year"; // Track the current view mode
boolean showCongrats = false;
String congratsMessage = "";
int congratsTimer = 0;
String startYearString;
String startMonthString;
String startDayString; 

Table marketTable; //table to save the data
int startRow = 0; // Start row 
int totalRows; // Total number of rows in the table

Turtle t;  //turtle used to draw fthe ive-pointed star

  void setup() {
    size(1200, 800);
    textSize(18);
    
      //load the dataset data of file 
    marketTable = loadTable("market_data.csv", "header");
    totalRows = marketTable.getRowCount();
    TableRow row = marketTable.getRow(0); 
    
    //load the balance from data file. 
    String balanceString = row.getString("balance");
    balance = float(balanceString);   
    
    //load the start year, month and day from data file.
    startYearString= row.getString("startYear"); 
    startMonthString = row.getString("startMonth");
    startDayString = row.getString("startDay");
    
    int startYear = int(startYearString);
    int startMonth = int(startMonthString);
    int startDay = int(startDayString);
    int endYear = year();
    int endMonth = month(); 
    int endDay = day(); 
    
    //calculate the play days
    playDays= calculateTotalDays(startYear, startMonth, startDay, endYear, endMonth, endDay); 
    
    //load the inventary data from data file.
    String appleString = row.getString("Apple");
    String bananaString = row.getString("Banana");
    String cherryString = row.getString("Cherry");
    String grapeString = row.getString("Grape");
    String orangeString = row.getString("Orange");
    
    initializeMarket();
    
    userInventory.put("Apple", int(appleString));
    userInventory.put("Banana", int(bananaString));
    userInventory.put("Cherry", int(cherryString));
    userInventory.put("Grape", int(grapeString));
    userInventory.put("Orange", int(orangeString));
     
    simulateOneYear(); // Simulate one year of data at startup
    
     // Initialize the turtle at (0, 0)
    t = new Turtle(width / 2, height / 2);
    
     // Get the canvas of the Processing sketch
      Component comp = (Component) surface.getNative();
      
      // Traverse up the component hierarchy to find the parent Frame
      while (comp != null && !(comp instanceof Frame)) {
          comp = comp.getParent();
      }
      
      //add WindowListener to listen if canvas got closed
      if (comp != null) {
          Frame frame = (Frame) comp;
          addWindowListenerToFrame(frame);
      } else {
        println("Unable to find parent frame.");
      }
       
    
  }

void draw() {
  background(255);
  
  //initialize the all front end funtions. 
  displayMarket();
  displayUserInventory();
  displayPriceCurves();
  displayMessage();
  displayBalance();
  
  drawButton(50, 350, 100, 50, "Reset");
  drawButton(150, 350, 100, 50, "Refresh");
  drawButton(250, 350, 100, 50, "Buy");
  drawButton(350, 350, 100, 50, "Sell");
  
  drawButton(width - 200, height - 60, 60, 40, "Year");
  drawButton(width - 140, height - 60, 60, 40, "Month");
  drawButton(width - 80, height - 60, 60, 40, "Week");
  
  if (showCongrats) {
    displayCongratsMessage();
  //  displayTriumphEffect();
  
   // Draw the five-pointed star
   for (int i = 0; i < 5; i++) {
    t.forward(99);
    t.turn(144); // Turn right 144 degrees
   }
 }

  // Handle the timer for the congratulatory message
  if (congratsTimer > 0) {
    congratsTimer--;
  } else {
    showCongrats = false;
  }
  
}

//iniatize the fruit market and their price
void initializeMarket() {
  for (String fruit : fruits) {
    prices.put(fruit, 1.0); // Initial price of $1.00 for each fruit
    priceHistory.put(fruit, new ArrayList<Float>());
    priceHistory.get(fruit).add(1.0); // Initialize with the starting price
   // userInventory.put(fruit, 0); // User starts with 0 units of each fruit
  }
}

//simulate one year price trend.
void simulateOneYear() {
  for (int i = 0; i < SIMULATION_DAYS; i++) {
    updatePrices();
  }
  day = SIMULATION_DAYS;
}

//display fruit price in the market, and play dates
void displayMarket() {
  fill(0);
  textAlign(LEFT);
  text("Market", 50, 50);
  text("Play Days: " + playDays, 200, 50);
  text("Fruit", 50, 80);
  text("Price", 150, 80);

  int y = 110;
  for (int i = 0; i < fruits.length; i++) {
    String fruit = fruits[i];
    if (i == selectedFruitIndex) {
      fill(200, 200, 255); // Highlight selected fruit
    } else {
      fill(0);
    }
    text(fruit, 50, y);
    text("$" + prices.get(fruit), 150, y);
    y += 30;
  }
}

void displayUserInventory() {
  fill(0);
  textAlign(LEFT);
  text("Your Inventory", 400, 50);
  text("Fruit", 400, 80);
  text("Quantity", 500, 80);

  int y = 110;
  for (String fruit : fruits) {
    text(fruit, 400, y);
    text(userInventory.get(fruit), 500, y);
    y += 30;
  }
}

//display fruit price curves in the market
void displayPriceCurves() {
  int graphWidth = 800;
  int graphHeight = 100;
  int offsetX = 600;
  int offsetY = 90;

  for (int i = 0; i < fruits.length; i++) {
    String fruit = fruits[i];
    ArrayList<Float> history = priceHistory.get(fruit);
    int daysToShow;

    if (viewMode.equals("year")) {
      daysToShow = SIMULATION_DAYS;
    } else if (viewMode.equals("month")) {
      daysToShow = 30;
    } else {
      daysToShow = 7;
    }

    stroke(0);
    noFill();
    rect(offsetX, offsetY + i * graphHeight, graphWidth, graphHeight);

    fill(0);
    textAlign(LEFT);
    text(fruit, offsetX + 10, offsetY + i * graphHeight + 20); // Label each graph with the fruit name

    stroke(0, 0, 255);
    beginShape();
    for (int j = 0; j < daysToShow; j++) {
      int index = history.size() - daysToShow + j;
      if (index >= 0 && index < history.size()) {
        float x = map(j, 0, daysToShow - 1, offsetX, offsetX + graphWidth);
        float y = map(history.get(index), 0, 2, offsetY + i * graphHeight + graphHeight, offsetY + i * graphHeight);
        vertex(x, y);
      }
    }
    endShape();
  }
}

void displayMessage() {
  fill(255, 0, 0);
  textAlign(CENTER);
  text(message, width / 2, height - 30);
}

void displayBalance() { 
   fill(0); 
   textAlign(LEFT); 
   text("Balance: $" + balance, 50, height - 30);   
}

//check if balance reach the milestone of each $100, like $100, $200, $300, etc. 
void checkBalanceMilestones() { 
  int milestone = ((int)(balance / 100)) * 100; 
  if (milestone > lastMilestone && milestone % 100 == 0) { 
      congratsMessage = " Congratulations! Your balance has reached $" + milestone + "!"; 
      lastMilestone = milestone; 
      showCongrats = true;
      congratsTimer = 180; // Show the message for 180 frames (3 seconds at 60 FPS)
   } 
}


void mousePressed() {
  if (!transactionDone) {
    int y = 90;
    for (int i = 0; i < fruits.length; i++) {
      if (mouseY > y - 20 && mouseY < y + 10) { // Adjusted to better detect clicks
        selectedFruitIndex = i;
        break;
      }
      y += 30;
    }
  }
  
  
    if (mouseX > 50 && mouseX < 150 && mouseY > 350 && mouseY < 400) {
       restartGame(); 
    } else if (mouseX > 150 && mouseX < 250 && mouseY > 350 && mouseY < 400) {
         resetGame();
    } else if (mouseX > 250 && mouseX < 350 && mouseY > 350 && mouseY < 400) {
        handleTransaction(true); //buy fruit 
    }  else if (mouseX > 350 && mouseX < 450 && mouseY > 350 && mouseY < 400) {
        handleTransaction(false);  // sell fruit    
    }

  if (mouseY > height - 60 && mouseY < height - 20) {
    if (mouseX > width - 200 && mouseX < width - 150) {
      viewMode = "year";
    } else if (mouseX > width - 150 && mouseX < width - 100) {
      viewMode = "month";
    } else if (mouseX > width - 100 && mouseX < width - 50) {
      viewMode = "week";
    }
  }
}

void handleTransaction(boolean buySellFlag)  {
  if (selectedFruitIndex != -1) {
    String fruit = fruits[selectedFruitIndex];
    
    if (buySellFlag == true) {
      buyFruit(fruit);
    } else if (buySellFlag == false) {
      sellFruit(fruit);
    }
    transactionDone = true;
  } else {
    message = "Please select a fruit first.";
  }
}

//buy fruit 1 unit price each time 
void buyFruit(String fruit) { 
  float price = prices.get(fruit); 
  if (balance >= price) { 
      userInventory.put(fruit, userInventory.get(fruit) + 1); 
      balance -= price; 
       message = "Bought 1 " + fruit + " for $" + price; 
       checkBalanceMilestones();
    } else { 
        message = "Not enough balance to buy " + fruit; 
    } 
    updatePrices(); 
 }
      
//sell fruit 1 unit price each time 
void sellFruit(String fruit) {
  if (userInventory.get(fruit) > 0) {
    float price = prices.get(fruit);
    userInventory.put(fruit, userInventory.get(fruit) - 1);
    balance += price;
    message = "Sold 1 " + fruit + " for $" + price;
    checkBalanceMilestones();
    updatePrices();
  } else {
    message = "You don't have any " + fruit + " to sell.";
  }
}

void updatePrices() {
  day++;  
  
  for (String fruit : fruits) {
    float newPrice = prices.get(fruit) * (0.95 + 0.1 * random.nextFloat()); // Fluctuate price by ±5%
    newPrice = constrain(newPrice, MIN_PRICE, 2.0); // Constrain between $0.10 and $2.00
    prices.put(fruit, round(newPrice * 100) / 100.0); // Round to 2 decimal places
    priceHistory.get(fruit).add(newPrice); // Add new price to history
  }
}

void keyPressed() {
  if (key == 'N' || key == 'n') {
    transactionDone = false;
    message = "";
  } else if (key == 'R' || key == 'r') {
    resetGame();
  } else if (key == 'X' || key == 'x'){
    handleTransaction(true); //buy fruit 
  } else if (key == 'Z' || key == 'z'){
    handleTransaction(false);  // sell fruit
  }
}

void resetGame() { 
  // day = 0; 
   selectedFruitIndex = -1; // Clear selected fruit to allow new selection 
   transactionDone = false; //start new transaction
   initializeMarket();
   simulateOneYear(); // Resimulate one year of data on reset    
   message = "Market has been reset. You can now select a different fruit to buy or sell."; 
     
}

void restartGame() { 
   day = 0; 
   selectedFruitIndex = -1; // Clear selected fruit to allow new selection 
   transactionDone = false; //start new transaction
   initializeMarket();
   simulateOneYear(); // Resimulate one year of data on reset    
   message = "Market has been reset. You can now select a different fruit to buy or sell."; 
   
  // Perform any necessary cleanup or save state
  balance = 100.0; 
  startYearString = "" + year(); 
  startMonthString = ""+ month(); 
  startDayString = ""+ day(); 
  
   int startYear = int(startYearString);
    int startMonth = int(startMonthString);
    int startDay = int(startDayString);
    int endYear = year();
    int endMonth = month(); 
    int endDay = day(); 
    playDays= calculateTotalDays(startYear, startMonth, startDay, endYear, endMonth, endDay); 
  
  for (String fruit : fruits) { 
    userInventory.put(fruit, 0); // User starts with 0 units of each fruit
  } 
  
  updateCSV(0, "balance", "" + balance);
  updateCSV(0, "startYear", startYearString);
  updateCSV(0, "startMonth", startMonthString);
  updateCSV(0, "startDay", startDayString);           
  updateCSV(0, "Apple", ""+userInventory.get("Apple"));
  updateCSV(0, "Banana", ""+userInventory.get("Banana"));
  updateCSV(0, "Cherry", ""+userInventory.get("Cherry"));
  updateCSV(0, "Grape", ""+userInventory.get("Grape"));
  updateCSV(0, "Orange", ""+userInventory.get("Orange"));
  
  // Save the updated data back to the file
   saveTable(marketTable, "data/market_data.csv");
            
    println("to save data in csv file ");    
     
}


// Function to calculate total days including weekends 
int calculateTotalDays(int startYear, int startMonth, int startDay, int endYear, int endMonth, int endDay) { 
  Calendar startCal = new GregorianCalendar(startYear, startMonth, startDay); 
  Calendar endCal = new GregorianCalendar(endYear, endMonth, endDay); 
  int totalDaysCount = 0; 
  while (startCal.before(endCal) || startCal.equals(endCal)) { 
    totalDaysCount++; 
    startCal.add(Calendar.DAY_OF_MONTH, 1); 
  } 
  return totalDaysCount; 
}

// Function to add a WindowListener to the frame
void addWindowListenerToFrame(Frame frame) {
    frame.addWindowListener(new WindowAdapter() {
        @Override
        public void windowClosing(WindowEvent e) {
            println("Window is closing...");
            // Perform any necessary cleanup or save state
            updateCSV(0, "balance", "" + balance);
            updateCSV(0, "startYear", startYearString);
            updateCSV(0, "startMonth", startMonthString);
            updateCSV(0, "startDay", startDayString);           
            updateCSV(0, "Apple", ""+userInventory.get("Apple"));
            updateCSV(0, "Banana", ""+userInventory.get("Banana"));
            updateCSV(0, "Cherry", ""+userInventory.get("Cherry"));
            updateCSV(0, "Grape", ""+userInventory.get("Grape"));
            updateCSV(0, "Orange", ""+userInventory.get("Orange"));
                       
             // Save the updated data back to the file
            saveTable(marketTable, "data/market_data.csv");
            
            println("to save data in csv file "); 
            
        }
        
        @Override
        public void windowClosed(WindowEvent e) {
            println("Window closed.");
            // Handle the window closed event
        }
    });
}

// Function to update the CSV data
void updateCSV(int row, String column, String newValue) {
    TableRow marketData = marketTable.getRow(row);
    if (marketData != null) {
        marketData.setString(column, newValue);
    } else {
        println("Row index out of range.");
    }
}


void drawButton(float x, float y, float w, float h, String label) {
    if (mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h) {
        fill(200); // Lighter color when hovered
    } else {
        fill(150); // Normal color
    }
    rect(x, y, w, h); // Draw button rectangle
    
    fill(0);
    textSize(16);
    textAlign(CENTER, CENTER);
    text(label, x + w / 2, y + h / 2); // Draw button label
}


void displayCongratsMessage() {
  fill(0, 255, 0);
  textAlign(CENTER);
  textSize(32);
  text(congratsMessage, width / 2, height / 2);
  textSize(18); // Reset text size
}

void displayTriumphEffect() {
  strokeWeight(4);
  stroke(255, 215, 0); // Gold color
  noFill();
  for (int i = 0; i < 8; i++) {
    float angle = TWO_PI / 8 * i;
    float x = width / 2 + cos(angle) * 100;
    float y = height / 2 + sin(angle) * 100;
    line(width / 2, height / 2, x, y);
  }
  strokeWeight(1);
}

String getFormattedTime() {
  return nf(hour(), 2) + ":" + nf(minute(), 2) + ":" + nf(second(), 2);
}

class Turtle {
  PVector pos;
  PVector heading;

  // Constructor
  Turtle(float x, float y) {
    pos = new PVector(x, y);
    heading = new PVector(1, 0); // Initial heading to the right (1, 0)
  }

  void turn(int turnAmt) {
    heading.rotate(radians(turnAmt));
  }

  void forward(float amount) {
    //PVector step = heading.copy().mult(amount);
    //pos.add(step);
    PVector oldPos = pos.copy(); 
    pos.add(PVector.mult(heading, amount));
    line (oldPos.x, oldPos.y, pos.x, pos.y); 
  }

  void teleport(float x, float y) {
    pos.set(x, y);
  }

  PVector getPosition() {
    return pos.copy();
  }
}
