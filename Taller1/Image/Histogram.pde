class Histogram {
  PImage img;
  int[] data;
  
  Histogram(PImage img) {
    this.img = img;
    this.data = new int[256];
  }
  
  void loadGray() {
    for(int i = 0; i < img.width; i++) {
      for(int j = 0; j < img.height; j++) {
        int loc = i + j*img.width;
        int c = int(img.pixels[loc]);
        data[c] += 1;
      }
    }  
  }
  
  void display(int ox, int oy, color c, int scale) {
    stroke(c);
    int ini = ox;
    for (int i = 0; i < 256; i++) {
      line(ini, oy, ini, (oy-data[i]/scale));
      ini += 3;
    }
    stroke(0);
  }
}
