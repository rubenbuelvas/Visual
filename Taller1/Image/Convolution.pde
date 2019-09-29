
static class ConvMask {
  static final int CM_SIZE = 3;
  static final float[][] EDGE_DETECT1 = { { -1, -1, -1 }, 
                                          { -1,  8, -1 }, 
                                          { -1, -1, -1 } };
 
  static final float[][] EDGE_DETECT2 = { {  1,  0, -1 }, 
                                          {  0,  0,  0 }, 
                                          { -1,  0,  1 } };

  static final float[][] IDENTITY = { {  0,  0,  0 }, 
                                      {  0,  1,  0 }, 
                                      {  0,  0,  0 } };
                                      
  static float[][] mask(int id) {
     switch(id) {
       case 0:
       return ConvMask.EDGE_DETECT1;
       case 1:
       return ConvMask.EDGE_DETECT2;
       default:
       return ConvMask.IDENTITY;
     }
  }
  
  static int size(int id) {
    switch(id) {
      // TODO:
      default:
      return 3;
    }
  }
}

class Convolution {
  String imgName;
  PImage img;

  Convolution(String name) {
    this.imgName = name;
    this.img = loadImage(imgName);
  }
  

/*PGraphics apply(float[][] matrix, int matrixsize) {
  loadPixels();
  // Begin our loop for every pixel in the smaller image
  for (int x = 0; x < img.width; x++) {
    for (int y = 0; y < img.height; y++ ) {
      color c = conv(x, y, matrix, matrixsize, img);
      int loc = x + y*img.width;
      pixels[loc] = c;
    }
  }
  updatePixels();
}*/

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

}
