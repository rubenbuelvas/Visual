class SteppingFeet {
  PGraphics pg;
  int innerx, innery;
  boolean show;
  int Y_AXIS = 1;
  int X_AXIS = 2;
  color c1, c2;
  int c;
  
  SteppingFeet(int sx, int sy) {
      this.pg = createGraphics(sx, sy);
      this.show = true;
      c1 = color(0);
      c2 = color(255);
      c = 0;
  }
  
  void display(int x, int y) {
    pg.beginDraw();
    pg.background(128);
    
    if(this.show) {
      pg.background(255);
      pg.fill(0);
      pg.stroke(0);
      for(int i=0; i<20; i++){
          pg.rect(i*pg.width/20, 0, pg.width/40, pg.height);
      }
    }
    
    pg.fill(c1);
    pg.stroke(c1);
    pg.rect(c, 62, 60, 30);
    pg.fill(c2);
    pg.stroke(c2);
    pg.rect(c, 187, 60, 30);
    c++;
    if(c>=pg.width){
      c = 0;
    }
    pg.endDraw();
    image(pg, x, y);
  }
  
  void action() {
    this.show = !this.show;
  }
  
}
