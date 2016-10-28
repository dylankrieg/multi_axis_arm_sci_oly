boolean getA() {
  return controller.getButton("buttonA").pressed();
}
boolean getUp() {
  return controller.getButton("up").pressed();
}
boolean getDown() {
  return controller.getButton("down").pressed();
}
boolean getLeft() {
  return controller.getButton("left").pressed();
}
boolean getLeftBumper() {
  return controller.getButton("leftBumper").pressed();
}
boolean getRightBumper() {
  return controller.getButton("rightBumper").pressed();
}
boolean getRight() {
  return controller.getButton("right").pressed();
}
float getLeftX() {
  return controller.getSlider("leftX").getValue();
}
float getLeftY() {
  return controller.getSlider("leftY").getValue();
}
float getRightX() {
  return controller.getSlider("rightX").getValue();
}
float getRightY() {
  return controller.getSlider("rightY").getValue();
}

