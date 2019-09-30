import processing.video.*;
PGraphics pg0, pg1, pg2;
PImage img;
Movie movie; //640x360
int c;
String fps;
 
 
void setup() 
{
  size(1280, 720);
  c = 0;
  fps = "";
  movie = new Movie(this, "lucas.mp4");
  movie.loop();
 
}
 
void movieEvent(Movie m) {
  m.read();
}
 
void draw() 
{
  background(0);  
  image(movie, 0, 0);
  image(luma(movie), 640, 0); 
  image(convolute(movie, 2), 640, 360); 
  
  c++;
  textSize(26);
  text(fps, 30, 400);
  if(c % 10 == 0){
    fps = "FPS: " + int(frameRate);
  }
}



PGraphics convolute(PImage img, int maskId) {
      PGraphics pg = createGraphics(640, 360);
      pg.beginDraw();
      pg.loadPixels();
      for (int x = 0; x < img.width; x++) {
        for (int y = 0; y < img.height; y++ ) {
          color c = conv(x, y, ConvMask.mask(maskId), ConvMask.size(maskId), img);
          int loc = x + y*img.width;
          pg.pixels[loc] = c;
        }
      }
      pg.updatePixels();
      pg.endDraw();
      return pg;
    }
    
 color conv(int x, int y, float[][] matrix, int matrixsize, PImage img){
  float rtotal = 0.0;
  float gtotal = 0.0;
  float btotal = 0.0;
  int offset = matrixsize / 2;
  for (int i = 0; i < matrixsize; i++){
    for (int j= 0; j < matrixsize; j++){
      
      int xloc = x+i-offset;
      int yloc = y+j-offset;
      int loc = xloc + img.width*yloc;
      
      loc = constrain(loc,0,img.pixels.length-1);
      
      rtotal += (red(img.pixels[loc]) * matrix[i][j]);
      gtotal += (green(img.pixels[loc]) * matrix[i][j]);
      btotal += (blue(img.pixels[loc]) * matrix[i][j]);
    }
  }
  
  rtotal = constrain(rtotal, 0, 255);
  gtotal = constrain(gtotal, 0, 255);
  btotal = constrain(btotal, 0, 255);
  
  return color(rtotal, gtotal, btotal);
}

PGraphics luma(PImage img) {
  PGraphics pg = createGraphics(640, 360);
  pg.beginDraw();
  pg.loadPixels();
  for (int x = 0; x < img.width; x++) {
    for (int y = 0; y < img.height; y++ ) {
      int loc = x + y*img.width;
      color p = img.pixels[loc];
      pg.pixels[loc] = color(0.212*(red(p)) + 0.701*green(p) + 0.087*blue(p));
    }
  }
  pg.updatePixels();
  pg.endDraw();
  return pg;
}
