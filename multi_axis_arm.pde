void setup() {
  size(600, 600);
  font=createFont("Courier",45);
  strokeWeight(2);
  strokeCap(SQUARE);
  textFont(font);
  connected=false; //True if the arduino is connected
  controllerConnected=false;
  base=new PVector(width/4, height); //The location of the arms base
  cursor=new PVector(width/4,height/4);
  cursor2=new PVector(width*0.75,height/4);
  int[] servoPorts= {
    7, 8, 9
  };
  mouse=new PVector(0, 0);
  armSpeed=5; //May not be implemented yet
  currentServo=new PVector(0, 0, 0);
  armLength=100;
  /*This is the number of servos on the arm, not including rotation on the base
   The servos should range in movement from 0-180 degrees */
  servoCount=3;
  servos=new ArrayList<PVector>();
  servo=new PVector(0, 0, 0);
  //180 is straight up, 90 is to the right
  control=ControlIO.getInstance(this);
  controller=control.getMatchedDevice("xboxcontroller");
  if (controller==null) {
    println("Controller not connected");
    connected=false;
  }
  if (connected) { //Block of code for interfacing with the arduino
    arduino=new Arduino(this, Arduino.list()[1], 57600); //Baud rate
    for (int port : servoPorts) {
      arduino.pinMode(port, Arduino.SERVO);
    }
  }
  resetServos();
}
void resetServos() { //This block is executed each time the program is ran
  servos.add(new PVector(base.x, base.y, 135)); //The angle and position of the first servo
  for (int i=0; i<servoCount; i++) {
    servos.add(new PVector(0, 0, 90));
  }
  if(connected) {
    for (int port : servoPorts) {
      arduino.servoWrite(port, 90);
    }
    delay(400);
  }
}
void draw() {
  for (int i=1; i<servos.size (); i++) {
    servo=(PVector)servos.get(i-1);
    servo2=(PVector)servos.get(i);
    servos.set(i, new PVector(servo.x+armLength*sin(radians(servo.z)), servo.y+armLength*cos(radians(servo.z)), servo2.z));stuff=getAngles(mouse); //Prints the servos angle
//    println(stuff);
  }
  if(connected) {
    setServos();
  }
  mouse.x=mouseX;
  mouse.y=mouseY;
  drawGraphics();


}
void drawGraphics() { 
  background(255);
  for (int i=1; i<servos.size (); i++) {
    servo=(PVector)servos.get(i-1);
    servo2=(PVector)servos.get(i);
    line(servo.x, servo.y, servo2.x, servo2.y);
  }
  drawBoxes();
}


void setServos() {
  for(int i=0;i<servos.size();i++) {
    servo=(PVector)servos.get(i);
    arduino.servoWrite(servoPorts[i],int(servo.z));
  }
  delay(50);
}

int[] getAngles(PVector p) {
  int[] angles=new int[servos.size()];
  for (int i=0; i<servos.size (); i++) {
    currentServo=(PVector)servos.get(i);
    angles[i]=int(currentServo.z);
  }
  return angles;
}

void drawBoxes() {
  //Left box
  rect(0,0,width/2,height/2);
  cursor.x+=getLeftX()*1.7;
  cursor.y+=getLeftY()*1.7;
  cursor.x=constrain(cursor.x,0,width/2);
  cursor.y=constrain(cursor.y,0,height/2);
//Code below for direct control
//  cursor.x=width/4+(getLeftX()*(width/4));
//  cursor.y=height/4+(getLeftY()*(height/4));
  fill(255);
  ellipse(cursor.x,cursor.y,50,50);
  
  //Right box
  rect(width/2,0,width/2,height/2);
  line(width*0.75,0,width*0.75,height/2);
  //For bumper control
  if(getRightBumper()&controllerConnected) {
    cursor2.y+=1.2;
  }
  if(getLeftBumper()&controllerConnected) {
    cursor2.y-=1.2;
  }
  cursor2.y=constrain(cursor2.y,0,height/2);
  //For joystick control of up/down
//  cursor2.y+=getRightY()*2;
//  cursor2.y=constrain(cursor2.y,0,height/2);

//  cursor2.x.constrain(cursor2.x,width/2,width);
//  cursor2.y=constrain(cursor2.y,height/2,height)
//Code below for direct control
//  cursor2.x=(width/2)+(width/4)+(getRightX()*(width/4));
//  cursor2.y=height/4+(getRightY()*(height/4));
  fill(255);
  ellipse(cursor2.x,cursor2.y,50,50);
}

void keyPressed() {
  if (key=='a') {
    currentServo=(PVector)servos.get(0);
    servos.set(0, new PVector(currentServo.x, currentServo.y, currentServo.z+armSpeed));
  } else if (key=='d') {
    currentServo=(PVector)servos.get(0);
    servos.set(0, new PVector(currentServo.x, currentServo.y, currentServo.z-armSpeed));
  }  
  if (key=='l') {
    currentServo=(PVector)servos.get(1);
    servos.set(1, new PVector(currentServo.x, currentServo.y, currentServo.z+armSpeed));
  } else if (key=='j') {
    currentServo=(PVector)servos.get(1);
    servos.set(1, new PVector(currentServo.x, currentServo.y, currentServo.z-armSpeed));
  }  
  if (key=='[') {
    currentServo=(PVector)servos.get(2);
    servos.set(2, new PVector(currentServo.x, currentServo.y, currentServo.z+armSpeed));
  } else if (key==']') {
    currentServo=(PVector)servos.get(2);
    servos.set(2, new PVector(currentServo.x, currentServo.y, currentServo.z-armSpeed));
  }
}





