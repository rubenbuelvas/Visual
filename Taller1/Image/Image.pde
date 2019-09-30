Canvas canvas;
PImage mainImg;
Histogram histogram;
Handle[] handles;
int min, max, mode;
Button[] buttons;

int pad = 40;
int osx = 320, osy = 320;
int csx = 320, csy = 320;

int ohx = osx+csx/2+280, hoy = 500, fhx = ohx+3*255;

void setup() {
  size(1550, 600);
  textAlign(CENTER, CENTER);

  mode = -1;   // GAVG

  mainImg = loadImage("cheesecake.jpg");
  
  canvas = new Canvas("cheesecake.jpg");
  selectMode(-1);
  
  handles = new Handle[2];
  handles[0] = new Handle(ohx, hoy, ohx, fhx);
  handles[1] = new Handle(fhx, hoy, ohx, fhx);
  
  histogram = new Histogram(canvas.img, 50);
  histogram.loadGray(canvas.img);
  
  buttons = new Button[7];
  buttons[0] = new Button("GAVG", color(50));
  buttons[1] = new Button("LUMA", color(50));
  buttons[2] = new Button("SHARPEN", color(50));
  buttons[3] = new Button("EDGE DETECT", color(50));
  buttons[4] = new Button("SHARPEN 2", color(50));
  buttons[5] = new Button("EDGE DETECT 2", color(50));
  buttons[6] = new Button("BLUR", color(50));
}

void draw() {  
  System.out.println(mode);
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
  
  canvas.display(osx+60, 180, csx, csy);
  canvas.segment(
    map(handles[0].dx, ohx, fhx, 0, 255),
    map(handles[1].dx, ohx, fhx, 0, 255)
  );
  histogram.displayGray(ohx, 500, handles[0].dx, handles[1].dx);
  
  for(int i = 0; i < buttons.length; i++) {
    if(buttons[i].update()) 
      selectMode(i);
    buttons[i].display(0, 10+40*i, 220, 30);
  }
  
  for(int i = 0; i < 2; i++) {
    handles[i].update();
    handles[i].display();
  }
  
}

void selectMode(int change) {
  switch(change) {
    case 0:
       canvas.filt(CanvasModes.GAVG);
       mode = 0;
      break;
    case 1:
        canvas.filt(CanvasModes.LUMA);
        mode = 1;
        break;
    case 2:
      canvas.convolute(ConvModes.SHARPEN);
      mode = 2;
      break;
    case 3:
      canvas.convolute(ConvModes.EDGE_DETECT1);
      mode = 3;
      break;
    case 4:
      canvas.convolute(ConvModes.SHARPEN2);
      break;
    case 5:
      canvas.convolute(ConvModes.EDGE_DETECT2);
      break;
    case 6:
      canvas.convolute(ConvModes.BOX_BLUR);
      break;
  }
  mode = change;
}

void mouseReleased() {
  for(int i = 0; i < 2; i++)  handles[i].release();  
}
