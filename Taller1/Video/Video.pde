import processing.video.*;
Movie myMovie;

void setup() {
  size(640, 400);
  background(0);
  myMovie = new Movie(this, "lucas.mp4");
  myMovie.loop();
}

void draw() {
  image(myMovie, 0, 0);
}

// Called every time a new frame is available to read
void movieEvent(Movie m) {
  m.read();
}
