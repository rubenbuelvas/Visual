static final int MSIZE = 3;
static final float[][] convMatrix = { { -1, -1, -1 }, 
                                      { -1,  9, -1 }, 
                                      { -1, -1, -1 } };

PImage img, grayImg, lumaImg, convImg;
int[] grayHistogram, lumaHistogram;

void setup() {
  grayHistogram = new int[256];
  lumaHistogram = new int[256];
  size(980, 640);
  img = loadImage("cheesecake.jpg");
  grayImg = grayAvg("cheesecake.jpg");
  convImg = convolution("cheesecake.jpg");
}

void draw() {
  image(img, 20, 20, 300, 300);  
  image(grayImg, 340, 20, 300, 300);
  image(lumaImg, 660, 20, 300, 300);
  displayHistogram(grayHistogram, 100, 600, color(100));
  displayHistogram(lumaHistogram, 100, 600, color(150));
}

void displayHistogram(int[] histogram, int ox, int oy, color c) {
  stroke(c);
  int ini = ox;
  for (int i = 0; i < 256; i++) {
    line(ini, oy, ini, (oy-histogram[i]/50));
    ini += 3;
  }
  stroke(0);
}

PImage grayAvg(String imgName) {
  PImage pimg = loadImage(imgName);
  pimg.loadPixels();
  for (int i = 0; i < pimg.height; i++) {
    for (int j = 0; j < pimg.width; j++) {
      int idx = i*pimg.width+j%pimg.height;
      color p = pimg.pixels[idx];
      grayHistogram[int((red(p) + blue(p) + green(p)) / 3)] += 1;
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
      lumaHistogram[int(0.2627*(red(p)) + 0.6780*green(p) + 0.0593*blue(p))] += 1;
    }
  }
  pimg.updatePixels();  
  return pimg;
}


PImage convolution(String imgName) {
  PImage pimg = loadImage(imgName);
  pimg.loadPixels();
  // Begin our loop for every pixel in the smaller image
  for (int x = 0; x < pimg.width; x++) {
    for (int y = 0; y < pimg.height; y++ ) {
      color c = conv(x, y, convMatrix, MSIZE, img);
      int loc = x + y*img.width;
      pixels[loc] = c;
    }
  }
  pimg.updatePixels();
  return pimg;
}

color conv(int x, int y, float[][] matrix, int matrixsize, PImage img)
{
  float rtotal = 0.0;
  float gtotal = 0.0;
  float btotal = 0.0;
  int offset = matrixsize / 2;
  for (int i = 0; i < matrixsize; i++){
    for (int j= 0; j < matrixsize; j++){
      // What pixel are we testing
      int xloc = x+i-offset;
      int yloc = y+j-offset;
      int loc = xloc + img.width*yloc;
      // Make sure we haven't walked off our image, we could do better here
      loc = constrain(loc,0,img.pixels.length-1);
      // Calculate the convolution
      rtotal += (red(img.pixels[loc]) * matrix[i][j]);
      gtotal += (green(img.pixels[loc]) * matrix[i][j]);
      btotal += (blue(img.pixels[loc]) * matrix[i][j]);
    }
  }
  // Make sure RGB is within range
  rtotal = constrain(rtotal, 0, 255);
  gtotal = constrain(gtotal, 0, 255);
  btotal = constrain(btotal, 0, 255);
  // Return the resulting color
  return color(rtotal, gtotal, btotal);
}
