import processing.video.*;
PGraphics pg0, pg1;
PImage img;
Movie movie; //640x360
int c;
String fps;
 
 
void setup() 
{
  size(1280, 720);
  c = 0;
  fps = "";
  pg0 = createGraphics(640, 360);
  pg1 = createGraphics(640, 360);
  movie = new Movie(this, "lucas.mp4");
  movie.loop();
 
}
 
void movieEvent(Movie m) {
  m.read();
}
 
void draw() 
{
  background(0);
  pg0.beginDraw();
  //pg.image(img, 0, 0, width, height);
  pg0.image(movie, 0, 0);
  pg0.endDraw();
  image(pg0, 0, 0); 
  pg1.beginDraw();
  //pg.image(img, 0, 0, width, height);
  pg1.image(movie, 0, 0);
  pg1.endDraw();
  image(pg0, 640, 0); 
  c++;
  textSize(26);
  text(fps, 30, 380);
  if(c % 10 == 0){
    fps = "FPS: " + int(frameRate);
  }
}
