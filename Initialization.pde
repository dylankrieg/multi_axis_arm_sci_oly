import org.gamecontrolplus.*;
import net.java.games.input.*;
import processing.serial.*;
import cc.arduino.*;
ArrayList servos; //This list contains the position of each servo and it's angle
int servoCount;
int armLength; //The length of each linkage of the arm
PVector servo,servo2;
PVector base;
PVector currentServo;
PVector cursor,cursor2;
int armSpeed;
PVector mouse;
int servoAngle;
int stuff[];
int[] servoPorts;
boolean connected;
boolean controllerConnected;
PFont font;
Arduino arduino;
ControlIO control;
ControlDevice controller;
