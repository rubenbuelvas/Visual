class Button {
  String text;
  color c;
  boolean over, pressed;
  int x1, sizeX, y1, sizeY;
  
  Button(String text, color c) {
    this.text = text;
    this.over = this.pressed = false;
    this.c = c;
  }
  
  boolean update() {
    return onPressed();
  }
  
  void display(int x1, int y1, int sizeX, int sizeY) {
    this.x1 = x1;
    this.sizeX = sizeX;
    this.y1 = y1;
    this.sizeY = sizeY;
    
    pushStyle();
    noStroke();
    textAlign(LEFT, TOP);
    fill(onPressed() ? 0 : (onHover() ? 255 : c));
    rect(x1, y1, sizeX, sizeY);
    fill(onPressed() ? 0 : 255);
    text(text, x1+10, y1);
    popStyle();
  }
  
  boolean onHover() {
    return (mouseX >= x1 && mouseX <= x1+sizeX && 
      mouseY >= y1 && mouseY <= y1+sizeY);
  }
  
  boolean onPressed() {
    this.pressed = onHover() && mousePressed;
    return this.pressed;
  }
  
}
