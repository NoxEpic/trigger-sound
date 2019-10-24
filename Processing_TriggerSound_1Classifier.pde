//This demo triggers a text display with each new message
// Works with 1 classifier output, any number of classes
//Listens on port 12000 for message /wek/outputs (defaults)

//Necessary for OSC communication with Wekinator:
import oscP5.*;
import netP5.*;
import processing.sound.*;


OscP5 oscP5;
SinOsc sine;


//No need to edit:
PFont myFont, myBigFont;
final int myHeight = 400;
final int myWidth = 400;
int frameNum = 0;
int currentHue = 100;
int currentBrightness = 100;
int currentTextHue = 255;
String currentMessage = "";


void setup() {
  size(400, 400);

  sine = new SinOsc(this);
  sine.freq(220);
  sine.play();
  
  //Initialize OSC communication
  oscP5 = new OscP5(this, 12000); //listen for OSC messages on port 12000 (Wekinator default)
 
  colorMode(HSB);
  smooth();
  background(255);

  String typeTag = "f";
  //myFont = loadFont("SansSerif-14.vlw");
  myFont = createFont("Arial", 14);
  myBigFont = createFont("Arial", 80);
}

void draw() {
  frameRate(30);
  background(currentHue, 255, currentBrightness);
  drawText();
  
}

//This is called automatically when OSC message is received
void oscEvent(OscMessage theOscMessage) {
  println("received message");
  if (theOscMessage.checkAddrPattern("/wek/outputs")) {
    if (theOscMessage.checkTypetag("f")) {
      float a = theOscMessage.get(0).floatValue();
      println("received1");
      showMessage((int)a);
    }
  }
}

void showMessage(int i) {
  generateSound(i);
  currentTextHue = i+1;
  currentMessage = Integer.toString(i);
}

void generateSound(int i) {
  println(i);
  if (i ==1 ) {
    sine.freq(523.25);
  } else if (i ==2 ) {
    sine.freq(783.99);
  } else if (i ==3 ) {
    sine.freq(1046.50);
  } else if (i ==3 ) {
    sine.freq(1174.66);
  } else if (i ==4 ) {
    sine.freq(1318.51);
  }
}

//Write instructions to screen.
void drawText() {
  stroke(0);
  textFont(myFont);
  textAlign(LEFT, TOP); 
  fill(currentTextHue, 255, 255);

  text("Receives 1 classifier output message from wekinator", 10, 10);
  text("Listening for OSC message /wek/outputs, port 12000", 10, 30);

  textFont(myBigFont);
  text(currentMessage, 190, 180);
}
