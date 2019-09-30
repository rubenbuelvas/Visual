class Handle {
  int m = 10;
  int size = 15;
  int x, y, dx, max, min;
  boolean locked;
  
  Handle(int ox, int oy, int min, int max) {
    x = dx = ox;
    y = oy + m;
    this.max = max;
    this.min = min;
  }
  
  void update() {
    if(locked) {
      if(mouseX < min)  dx = min;
      //else if(mouseX > max)  dx = max;
      else dx = mouseX;
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
    locked = locked || onHover() && mousePressed;
    return locked;  
  }
  
  void release() {
    locked = false;  
  }
  
  boolean onHover() {
    return (mouseX >= dx-size/2-10 && mouseX <= dx+size/2+10 && 
      mouseY >= y-10 && mouseY <= y+size/2+10);  
  }
}
