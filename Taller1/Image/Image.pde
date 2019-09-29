Canvas canvas;
PImage mainImg, grayImg, lumaImg, convImg;
Histogram grayHistogram, lumaHistogram;

void setup() {
  size(980, 640);

  mainImg = loadImage("cheesecake.jpg");
  canvas = new Canvas("cheesecake.jpg", 400, 400);
}

void draw() {
  image(mainImg, 20, 20, 300, 300);
  canvas.apply(CanvasModes.GAVG);
  canvas.display(660, 20);
  //image(convImg, 660, 20, 300, 300);
  //displayHistogram(grayHistogram, 100, 600, color(100));
  //displayHistogram(lumaHistogram, 100, 600, color(150));
}
