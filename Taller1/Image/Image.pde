Canvas canvas;
PImage mainImg;
Histogram histogram;
Handle[] handles;
int min, max;

int pad = 40;
int osx = 320, osy = 320;
int csx = 320, csy = 320;

// 
int ohx = osx+csx/2+280, hoy = 500, fhx = ohx+3*255;

void setup() {
  size(1550, 600);
  textAlign(CENTER, CENTER);

  handles = new Handle[2];
  handles[0] = new Handle(ohx, hoy, ohx, fhx);
  handles[1] = new Handle(fhx, hoy, ohx, fhx);
  
  mainImg = loadImage("cheesecake.jpg");
  canvas = new Canvas("cheesecake.jpg");
  histogram = new Histogram(canvas.img, 50);
  //canvas.convolute(ConvModes.EDGE_DETECT1);
  canvas.apply(CanvasModes.LUMA);
  histogram.loadGray();
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
  textSize(20);
  text("Edited image", osx+60+csx/2, 520);
  
  //canvas.convolute(ConvModes.SHARPEN);
  
  canvas.display(osx+60, 180, csx, csy);
  canvas.segment(
    map(handles[0].dx, ohx, fhx, 0, 255),
    map(handles[1].dx, ohx, fhx, 0, 255)
  );
  histogram.displayGray(ohx, 500, handles[0].dx, handles[1].dx);
  
  for(int i = 0; i < 2; i++) {
    handles[i].update();
    handles[i].display();
  }
}

void mouseReleased() {
  for(int i = 0; i < 2; i++)  handles[i].release();  
}
