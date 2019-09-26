static final int CM_SIZE = 3;

PImage mainImg, grayImg, lumaImg, convImg;
Histogram grayHistogram, lumaHistogram;

void setup() {
  size(980, 640);
  
  mainImg = loadImage("cheesecake.jpg");
  grayImg = grayAvg("cheesecake.jpg");
  lumaImg = luma("cheesecake.jpg");
  
  grayHistogram = new Histogram(grayImg);
  lumaHistogram = new Histogram(lumaImg);
  //grayHistogram.loadGray();
  //lumaHistogram.loadGray();
  
  Convolution c = new Convolution("cheesecake.jpg");
  convImg = c.apply(ConvMask.EDGE_DETECT1, 3);
}

void draw() {
  image(mainImg, 20, 20, 300, 300);  
  image(grayImg, 340, 20, 300, 300);
  image(convImg, 660, 20, 300, 300);
  //displayHistogram(grayHistogram, 100, 600, color(100));
  //displayHistogram(lumaHistogram, 100, 600, color(150));
}

void displayHistogram(int[] histogram, int ox, int oy, color c) {
}

PImage grayAvg(String imgName) {
  PImage pimg = loadImage(imgName);
  pimg.loadPixels();
  for (int i = 0; i < pimg.height; i++) {
    for (int j = 0; j < pimg.width; j++) {
      int idx = i*pimg.width+j%pimg.height;
      color p = pimg.pixels[idx];
      //grayHistogram[int((red(p) + blue(p) + green(p)) / 3)] += 1;
      pimg.pixels[idx] = color((red(p) + blue(p) + green(p)) / 3);
    }
  }
  pimg.updatePixels();  
  return pimg;
}

PImage luma(String imgName) {
  PImage pimg = loadImage(imgName);
  pimg.loadPixels();
  for (int i = 0; i < pimg.height; i++) {
    for (int j = 0; j < pimg.width; j++) {
      color p = pimg.pixels[i*pimg.width+j%pimg.height];
      pimg.pixels[i*pimg.width+j%pimg.height] = color(0.2627*(red(p)) + 0.6780*green(p) + 0.0593*blue(p));
      //lumaHistogram[int(0.2627*(red(p)) + 0.6780*green(p) + 0.0593*blue(p))] += 1;
    }
  }
  pimg.updatePixels();  
  return pimg;
}
