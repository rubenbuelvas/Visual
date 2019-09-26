
static class ConvMask {
  static final int EDGE_DETECT_SIZE = 3;
  static final float[][] EDGE_DETECT1 = { { -1, -1, -1 }, 
                                          { -1,  8, -1 }, 
                                          { -1, -1, -1 } };
 
  static final float[][] EDGE_DETECT2 = { {  1,  0, -1 }, 
                                          {  0,  0,  0 }, 
                                          { -1,  0,  1 } };

  static final float[][] EDGE_DETECT3 = { {  0,  0,  0 }, 
                                          {  0,  1,  0 }, 
                                          {  0,  0,  0 } };
}

class Convolution {
  String imgName;
  PImage img;

  Convolution(String name) {
    this.imgName = name;
    this.img = loadImage(imgName);
  }
  

PImage apply(float[][] matrix, int matrixsize) {
  img.loadPixels();
  // Begin our loop for every pixel in the smaller image
  for (int x = 0; x < img.width; x++) {
    for (int y = 0; y < img.height; y++ ) {
      color c = conv(x, y, matrix, matrixsize, img);
      int loc = x + y*img.width;
      img.pixels[loc] = c;
    }
  }
  img.updatePixels();
  return img;
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

PImage altconvolution(String imgName) {
  PImage img = loadImage(imgName);
  for(int x = 0; x < img.width; x++) {
    for(int y = 0; y < img.height; y++) {
        float acc = 0;
        for(int i = 0; i < CM_SIZE; i++) {
          for(int j = 0; j < CM_SIZE; j++) {
              
          }
        }
    }
  }
  return img;
}
}
