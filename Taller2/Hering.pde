class Hering {
  PGraphics pg;
  int radius = 60;
  int offset = -10;
  int hLines = 20, vLines = 5;
  boolean show;
  
  Hering(int sx, int sy) {
      this.pg = createGraphics(sx, sy);
      this.show = true;
  }
  
  void display(int x, int y) {
    pg.beginDraw();
    
    pg.background(255);
    
    if(this.show) {
      // draw lines from the center to the horizontal edges
      for(int i = 0; i <= hLines; i++) {
        pg.line(i*pg.width/hLines, 0, pg.width/2, pg.height/2);
        pg.line(i*pg.width/hLines, pg.height, pg.width/2, pg.height/2);
      }
      
      // draw lines to vertical ones
      for(int i = 1; i <= vLines; i++) {
        // from top
        pg.line(0, i*pg.height/(3*vLines), pg.width/2, pg.height/2);
        pg.line(pg.width, i*pg.height/(3*vLines), pg.width/2, pg.height/2);
        
        // to bottom
        pg.line(0, (i+2*vLines)*pg.height/(3*vLines), pg.width/2, pg.height/2);
        pg.line(pg.width, (i+2*vLines)*pg.height/(3*vLines), pg.width/2, pg.height/2);
      }
    }
    
    // draw horizontal lines
    pg.pushStyle();
    pg.strokeWeight(2);
    pg.stroke(color(255, 0, 0));
    pg.line(0, pg.height/3, pg.width, pg.height/3);
    pg.line(0, 2*pg.height/3, pg.width, 2*pg.height/3);
    pg.popStyle();
    
    pg.endDraw();
    image(pg, x, y);
  }
  
  void action() {
    this.show = !this.show;
  }
}
