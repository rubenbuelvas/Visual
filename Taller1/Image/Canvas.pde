class Canvas {
    PGraphics pg;
    PImage original, img;
    String imgName;
    int sizeX, sizeY;

    Canvas(String imgName) {
        this.imgName = imgName;
        this.img = this.original = loadImage(imgName);
        this.sizeX = img.width;
        this.sizeY = img.height;
        this.pg = createGraphics(sizeX, sizeY);
        this.loadImg();
    }
   
    void display(int x, int y, int sx, int sy) {
        image(pg, x, y, sx, sy);
    }

    void loadImg() {
      pg.beginDraw();
      pg.image(img, 0, 0, sizeX, sizeY);
      pg.endDraw();
    }
    
    void reset() {
      this.img = this.original;  
    }
    
    void apply(int mode) {
      this.reset();
      switch(mode) {
        case CanvasModes.GAVG:
          this.grayAvg();
          break;
        case CanvasModes.LUMA:
          this.luma();
          break;
        default:
          System.out.println("working on it!");
      }
    }
    
    void convolute(int maskId) {
      this.reset();
      pg.loadPixels();
      // Begin our loop for every pixel in the smaller image
      for (int x = 0; x < img.width; x++) {
        for (int y = 0; y < img.height; y++ ) {
          color c = conv(x, y, ConvMask.mask(maskId), ConvMask.size(maskId), original);
          int loc = x + y*img.width;
          pg.pixels[loc] = c;
        }
      }
      pg.updatePixels();
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
    
    void grayAvg() {
      img.loadPixels();
      for (int i = 0; i < img.height; i++) {
        for (int j = 0; j < img.width; j++) {
          int idx = i*img.width+j%img.height;
          color p = img.pixels[idx];
          //grayHistogram[int((red(p) + blue(p) + green(p)) / 3)] += 1;
          img.pixels[idx] = color((red(p) + blue(p) + green(p)) / 3);
        }
      }
      img.updatePixels();
    }
    
    void luma() {
      img.loadPixels();
      for (int i = 0; i < img.height; i++) {
        for (int j = 0; j < img.width; j++) {
          color p = img.pixels[i*img.width+j%img.height];
          img.pixels[i*img.width+j%img.height] = color(0.2627*(red(p)) + 0.6780*green(p) + 0.0593*blue(p));
          //lumaHistogram[int(0.2627*(red(p)) + 0.6780*green(p) + 0.0593*blue(p))] += 1;
        }
      }
      img.updatePixels();
    }
}
