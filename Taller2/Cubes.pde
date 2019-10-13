class Cubes {
  PGraphics pg;
  PImage img;
  boolean show;
  
  Cubes(int sx, int sy) {
      this.pg = createGraphics(sx, sy);
      this.show = true;
      img = loadImage("cubes.jpg");
  }
  
  void display(int x, int y) {
    pg.beginDraw();
    pg.image(img, 0, 0, pg.width, pg.height);
    
    if(!this.show) {
      pg.rect(90, 135, 110, 40);
    }
    
    pg.endDraw();
    image(pg, x, y);
  }
  
  void action() {
    this.show = !this.show;
  }
  
}
