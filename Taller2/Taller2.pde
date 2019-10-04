int mode = -1;
int buttonOffset = 120;

CafeWall cw;
LilacChaser lc;

Button[] buttons;

void setup() {
  size(1200, 600);
  textAlign(CENTER, CENTER);
  
  buttons = new Button[6];
  buttons[0] = new Button("Cafe Wall", color(50));
  buttons[1] = new Button("Lilac Chaser", color(50));
  buttons[2] = new Button("Illusion 3", color(50));
  buttons[3] = new Button("Illusion 4", color(50));
  buttons[4] = new Button("Illusion 5", color(50));
  buttons[5] = new Button("Illusion 6", color(50));
  
  cw = new CafeWall(600, 250, 4);
  lc = new LilacChaser(300);
}

void draw() {
  background(0);  // why does this smooth text?
  textSize(36);
  text("Visual Computing - Optical Illusions", width/2, 40);
  textSize(16);
  text("José David Nieto, Rubén Camilo Buelvas\nUniversidad Nacional de Colombia", width/2, 100);
  
  displayIllusion(mode);
  for(int i = 0; i < buttons.length; i++) {
    if(buttons[i].update()) {
      mode = i;
    }
    buttons[i].display(0, buttonOffset+40*i, 220, 30);
  }
}

void displayIllusion(int c) {
  switch (c) {
    case 0:
      cw.display(400, 200);
      break;
    case 1:
      lc.display(400, 200);
      break;      
  }
}
