import processing.video.*;
Movie myMovie;
int c;
String fps;

void setup() {
  c = 0;
  fps = "0";
  size(640, 400);
  background(0);
  myMovie = new Movie(this, "lucas.mp4");
  myMovie.loop();
}

void draw() {
  background(0);
  image(myMovie, 0, 0);
  c++;
  text(fps, 30, 380);
  if(c % 10 == 0){
    fps = "FPS: " + int(frameRate);
  }
}

void movieEvent(Movie m) {
  m.read();
}
