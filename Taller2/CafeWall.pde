class CafeWall {
  PGraphics pg;
  int sizeX, sizeY, subs, time;
  boolean play;
  
  CafeWall(int sizeX, int sizeY, int subs) {
    this.play = true;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    this.subs = subs;
    this.time = 0;
    this.pg = createGraphics(sizeX, sizeY);
  }
    
  void display(int x, int y) {
    float h = sizeY/subs;
    
    pg.beginDraw();
    pg.pushStyle();
    pg.background(0);
    pg.stroke(color(100));
    pg.strokeWeight(2);
    for(int i = 0; i < subs; i++) {
      float f = i%2 == 0 ? 1 : -1;
      float iy = i*sizeY/subs;
      this.drawRow(iy, h, (f*10)+f*time);
    }
    pg.popStyle();
    pg.endDraw();
    image(pg, x, y, sizeX, sizeY);
    if(this.play) {
      time++;
      if(time%(2*h) == 0)  time = 0;
    }
  }
  
  void drawRow(float y, float h, float offset) {
    int i = -2;
    while(i*h <= (offset > 0 ? sizeX : sizeX + 2*h)) {
      pg.fill(i%2 == 0 ? 255 : 0);
      pg.rect(i*h+offset, y, h, h);
      i++;
    }
  }
  
  void action() {
    this.play = !this.play;
  }
}
