class GrayGradient {
  PGraphics pg;
  int innerx, innery;
  boolean show;
  int Y_AXIS = 1;
  int X_AXIS = 2;
  color c1, c2;
  
  GrayGradient(int sx, int sy) {
      this.pg = createGraphics(sx, sy);
      this.show = true;
      c1 = color(0);
      c2 = color(255);
  }
  
  void display(int x, int y) {
    pg.beginDraw();
    pg.background(255);
    
    if(this.show) {
      setGradient(0, 0, pg.width, pg.height, c1, c2, X_AXIS);
    }
    
    pg.fill(128);
    pg.stroke(128);
    pg.rect(100, 100, 400, 50);
    
    
    pg.endDraw();
    image(pg, x, y);
  }
  
  void action() {
    this.show = !this.show;
  }
  
  void setGradient(int x, int y, float w, float h, color c1, color c2, int axis ) {
    pg.noFill();
  
    if (axis == Y_AXIS) {  // Top to bottom gradient
      for (int i = y; i <= y+h; i++) {
        float inter = map(i, y, y+h, 0, 1);
        color c = lerpColor(c1, c2, inter);
        pg.stroke(c);
        pg.line(x, i, x+w, i);
      }
    }  
    else if (axis == X_AXIS) {  // Left to right gradient
      for (int i = x; i <= x+w; i++) {
        float inter = map(i, x, x+w, 0, 1);
        color c = lerpColor(c1, c2, inter);
        pg.stroke(c);
        pg.line(i, y, i, y+h);
      }
    }
  }
}
