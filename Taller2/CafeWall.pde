class CafeWall {
  PGraphics pg;
  int sizeX, sizeY, subs;
  
  CafeWall(int sizeX, int sizeY, int subs) {
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    this.subs = subs;
    this.pg = createGraphics(sizeX, sizeY);
  }
    
  void display(int x, int y) {
    this.load();
    image(pg, x, y, sizeX, sizeY);
  }
  
  void load() {
    pg.beginDraw();
    pg.pushStyle();
    pg.background(0);
    pg.stroke(color(100));
    pg.strokeWeight(2);
    for(int i = 0; i < subs; i++) {
      float iy = i*sizeY/subs;
      float h = sizeY/subs;
      this.drawRow(iy, h, ((i%2==0 ? 1 : -1)*10));
    }
    pg.popStyle();
    pg.endDraw();
  }
  
  void drawRow(float y, float h, float offset) {
    int i = 0;
    while(i*h <= sizeX) {
      pg.fill(i%2 == 0 ? 255 : 0);
      pg.rect(i*h+offset, y, h, h);
      i++;
    }
  }
}
