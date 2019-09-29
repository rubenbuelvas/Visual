class Histogram {
  int skip = 3;
  PImage img;
  int[] data;
  int[][] colorData;
  int dx1, dy1, dx2, dy2;
  
  Histogram(PImage img) {
    this.img = img;
    this.data = new int[256];
    this.colorData = new int[3][256];
    dx1 = dx2 = dy1 = dy2 = -1;
  }
  
  void loadGray() {
    for(int i = 0; i < img.width; i++) {
      for(int j = 0; j < img.height; j++) {
        int loc = i + j*img.width;
        //int c = (int) img.pixels[loc];
        int c = (int) brightness(img.pixels[loc]);
        data[c] += 1;
      }
    }  
  }
  
  void loadColor() {
    for(int i = 0; i < img.width; i++) {
      for(int j = 0; j < img.height; j++) {
        int loc = i + j*img.width;
        //int c = (int) img.pixels[loc];
        int r = (int) red(img.pixels[loc]);
        int g = (int) green(img.pixels[loc]);
        int b = (int) blue(img.pixels[loc]);
        colorData[0][r] += 1;
        colorData[1][g] += 1;
        colorData[2][b] += 1;
      }
    }  
  }
  
  void display(int ox, int oy, color c, int scale, int idx) {
    pushStyle();
    stroke(c);
    int ini = ox;
    for (int i = 0; i < 256; i++) {
      line(ini, oy, ini, (oy-(idx == -1 ? data[i] : colorData[idx][i])/scale));
      ini += skip;
    }
    popStyle();
  }
  void displayGray(int ox, int oy, int scale) {
    this.display(ox, oy, color(255), scale, -1);  
  }  
  
  void displayColor(int ox, int oy, int scale) {
    this.display(ox, oy, color(255, 0, 0), scale, 0);
    this.display(ox+1, oy, color(0, 255, 0), scale, 1);
    this.display(ox+2, oy, color(0, 0, 255), scale, 2);
  }
}
