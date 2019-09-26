import processing.video.*;
Movie myMovie;
int myFrameCount;

void setup() {
  myFrameCount = 0;
  size(640, 400);
  background(0);
  myMovie = new Movie(this, "lucas.mp4");
  myMovie.loop();
}

void draw() {
  background(0);
  image(myMovie, 0, 0);
  text(frameRate, 30, 380);
}

// Called every time a new frame is available to read
void movieEvent(Movie m) {
  m.read();
}
