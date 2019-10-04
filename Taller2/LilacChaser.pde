class LilacChaser {
  PGraphics pg;
  int wsize, wradius = 100, cradius = 20, circles = 12,
    blur = 4, crossSize = 8, time;
  
  LilacChaser(int wsize) {
    this.time = 0;
    this.wsize = wsize;
    this.pg = createGraphics(wsize, wsize);
  }
  
  void display(int x, int y) {
    pg.beginDraw();
    pg.background(100);
    pg.pushStyle();
    pg.noStroke();
    pg.fill(color(191, 134, 191));
    for(int i = 0; i < circles; i++) {
      if(time/3 % circles != i)
      pg.circle(
        wradius * cos(radians((i*360/circles)+15))+pg.width/2,
        wradius * sin(radians((i*360/circles)+15))+pg.height/2,
        cradius
      );
    }
    pg.filter(BLUR, blur);
    pg.stroke(0);
    pg.line(pg.width/2-crossSize, pg.height/2, pg.width/2+crossSize, pg.height/2);
    pg.line(pg.width/2, pg.height/2-crossSize, pg.width/2, pg.height/2+crossSize);
    pg.popStyle();
    pg.endDraw();
    image(pg, x, y, this.wsize, this.wsize);
    this.time++;
  }
}
