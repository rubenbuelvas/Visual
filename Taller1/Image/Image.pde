Canvas canvas;
PImage mainImg, grayImg, lumaImg, convImg;
Histogram grayHistogram, lumaHistogram;

int pad = 40;
int osx = 320, osy = 320;
int csx = 320, csy = 320;

void setup() {
  size(1366, 600);
  textAlign(CENTER, CENTER);

  mainImg = loadImage("cheesecake.jpg");
  canvas = new Canvas("cheesecake.jpg");
}

void draw() {
  background(102);  // why does this smooth text?
  textSize(36);
  text("Visual Computing - Image", width/2, 40);
  textSize(16);
  text("José David Nieto, Rubén Camilo Buelvas\nUniversidad Nacional de Colombia", width/2, 100);
  
  image(mainImg, pad, 180, osx, osy);
  textSize(20);
  text("Original image", pad+osx/2, 520);
  
  canvas.convolute(ConvModes.IDENTITY);
  canvas.display(osx+60, 180, csx, csy);
  textSize(20);
  text("Edited image", osx+60+csx/2, 520);
  //displayHistogram(grayHistogram, 100, 600, color(100));
  //displayHistogram(lumaHistogram, 100, 600, color(150));
}
