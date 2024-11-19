//Import jave apckage for clipboard copy and timestamp convertion
import java.awt.Toolkit;
import java.awt.datatransfer.StringSelection;
import java.awt.datatransfer.Clipboard;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.ZoneId;
import java.time.ZonedDateTime;

//Setup original color of hour, minute and second arc
color secondColor = #000000;
color minuteColor = #000000;
color hourColor = #000000;

//Retreive the values of time and date 
<<<<<<< HEAD
int hr =hour();
int originalHr = hour(); 
=======
int hr =11; //hour();
int originalHr = 11; //hour(); 
>>>>>>> 638c5f18b5e21e39dc62b5fca08776a03812312f
int min = minute();
int sec = second();
int today = day(); 
int thisYear = year();
int thismonth = month(); 
int mills = millis();

 boolean aMOrNot = true;    //to check if AM or PM
 float secondAngle = 0.0;
 float minuteAngle = 0.0; 
 float hourAngle = 0.0; 
 

void setup() {
  size(800, 800);
  
   // Determine AM or PM
  if (hr >= 12) {
    aMOrNot = false;
    
    //sSet arc colors for pm
    secondColor = #cbc3e3;
    minuteColor = #800080;
    hourColor = #0000ff;
    
    if (hr > 12) hr -= 12; // Convert to 12-hour format
  } else {
    aMOrNot = true; 
    
    //Set arc colors for am
    secondColor = #ffff00;
    minuteColor = #ffa500;
    hourColor = #ff0000;
    
    if (hr == 0) hr = 12; // Midnight case
  } 
  
  
  //Map second to radians
  secondAngle = map(sec, 0, 60, 0, PI);
  
  //Map minute to radians
  minuteAngle = map(min, 0, 60, 0, PI);  
  
  //Map hour to redians
  hourAngle = map(hr, 0, 12, 0, PI);
   
}

void draw() {
 
  //Setup the default style
  background(255);
  translate(width / 2, height / 2);
  rotate(-90);
  
  
  color midnightColor = color(25, 25, 112); // Dark blue for midnight
  color noonColor = color(135, 206, 235); // Light blue for noon
  
  color currentColor;
  if (originalHr  >= 6 && originalHr  <= 12) { // Morning to noon
    float t = map(originalHr , 6, 12, 0, 1);
    currentColor = lerpColor(midnightColor, noonColor, t);
  } else if (originalHr  > 12 && originalHr  <= 18) { // Noon to evening
    float t = map(originalHr, 12, 18, 0, 1);
    currentColor = lerpColor(noonColor, midnightColor, t);
  } else if (originalHr  > 18 && originalHr  < 24) { // Evening to midnight
    float t = map(originalHr , 18, 24, 0, 1);
    currentColor = lerpColor(midnightColor, midnightColor, t);
  } else { // Midnight to morning
    float t = map(originalHr, 0, 6, 0, 1);
    currentColor = lerpColor(midnightColor, midnightColor, t);
  }
  
  background(currentColor);
   
  
 //Draw the clock arcs for AM  
  if (aMOrNot) {
    
    //Draw the second arc
    stroke(secondColor);
    noFill();
    strokeWeight(8);
    arc(0, 0, 500, 500, 0, secondAngle);
    
    //Draw the minute arc
    stroke(minuteColor);
    strokeWeight(10);
    arc(0, 0, 480, 480, 0, minuteAngle); 
    
    //Draw the hour arc
    stroke(hourColor);
    strokeWeight(12); 
    arc(0, 0, 460, 460, 0, hourAngle); 
    
  }else{
    
    //Draw the clock arcs for PM 
    //Draw the second arc 
    stroke(secondColor);
    noFill();
    strokeWeight(8);
    arc(0, 0, 360, 360, 0, secondAngle);
    
    //Draw the minute arc
    stroke(minuteColor);
    strokeWeight(10);
    arc(0, 0, 380, 380, 0, minuteAngle);
    
    //Draw the hour arc
    stroke(hourColor);
    strokeWeight(12); 
    arc(0, 0, 400, 400, 0, hourAngle);
   
  }
  
  //Draw the time arc
  stroke(0, 0, 0);
  strokeWeight(12); 
  arc(0, 0, 430, 430, 0, TAU/2.0);
 
  // Number of segments
  int segments = 12;
  float angleStep = (TAU / 2.0) / segments;
  float tickLength = 20; // Length of the small tick lines

  if (aMOrNot) {     
    // Draw tick lines for each cut
    for (int i = 0; i <= segments; i++) {
      float angle = i * angleStep;
      float x1 = cos(angle) * 215; // End of the arc radius
      float y1 = sin(angle) * 215;
      float x2 = cos(angle) * (215 - tickLength); // Inner point of the tick
      float y2 = sin(angle) * (215 - tickLength);
      strokeWeight(5);
      line(x1, y1, x2, y2); // Draw the small tick line      
    }
  } else {
    // Draw tick lines for each cut
    for (int i = 0; i <= segments; i++) {
      float angle = i * angleStep;
      float x1 = cos(angle) * 215; // End of the arc radius
      float y1 = sin(angle) * 215;
      float x2 = cos(angle) * (215 + tickLength); // Outer point of the tick
      float y2 = sin(angle) * (215 + tickLength);
      strokeWeight(5);
      line(x1, y1, x2, y2); // Draw the small tick line     
    }
  }
  
  
}

//When mouse pressed, timestamp is copied to clipbaord. 
void mousePressed() {
  if (mouseOverCanvas()) {
    
    //Appended all date and time to string with following sample format: 2024-10-30 16:14:31:2
    String timeStampStr = "" +thisYear+"-"+thismonth+"-" +today + " " + originalHr+ ":" + min +":" +sec+ "";
    
    //Creates a localDateTime object.  
    LocalDateTime localDateTime = LocalDateTime.of(thisYear, thismonth, today, originalHr,  min, sec);
    println("time " + timeStampStr);
    
    //Converts the localDateTime object to a ZonedDateTime object at the system's default time zone. 
    ZonedDateTime zonedDateTime = localDateTime.atZone(ZoneId.systemDefault());
     
    //Get the Unix timestamp.
    long unixTimestamp = zonedDateTime.toEpochSecond();
    println("Unix Timestamp: " + unixTimestamp);

    // Use the timestamp to display a formatted Discord timestamp
    String discordTimestamp = "<t:" + unixTimestamp + ":R>";
    println("Discord Timestamp: " + discordTimestamp);
  
    copyToClipboard(discordTimestamp);
  }
}

//Determine if mouse inside the canvas
boolean mouseOverCanvas() {
  return (mouseX >= 0 && mouseX <= width && mouseY >= 0 && mouseY <= height);
}

//Copy selected text to clipboard using java API 
void copyToClipboard(String str) {
  StringSelection selection = new StringSelection(str);
  Clipboard clipboard = Toolkit.getDefaultToolkit().getSystemClipboard();
  clipboard.setContents(selection, selection);
}
