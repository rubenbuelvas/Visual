class Handle {
  int m = 10;
  int size = 15;
  int x, y, dx;
  
  Handle(int ox, int oy) {
    x = dx = ox;
    y = oy + m;
  }
  
  void update() {
    if(onPressed()) {
      dx = mouseX;
    }
  }
  
  void display() {

    pushStyle();
    
    noStroke();
    if(onHover()) { fill(color(255, 0, 0)); }
    if(onPressed()) { fill(color(0, 255, 0)); }
    triangle(dx, y, dx-size/2, y+size/2, dx+size/2, y+size/2);
    popStyle();
  }
  
  boolean onPressed() {
    return onHover() && mousePressed;  
  }
  
  boolean onHover() {
    return (mouseX >= dx-size/2-10 && mouseX <= dx+size/2+10 && 
      mouseY >= y-10 && mouseY <= y+size/2+10);  
  }
}
