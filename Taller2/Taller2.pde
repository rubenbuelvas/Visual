int mode = -1;
int buttonOffset = 180;

CafeWall cw;
LilacChaser lc;
Hering hr;
GrayGradient gg;
SteppingFeet sf;
Cubes cu;

Button[] buttons;
Button actionButton;

void setup() {
  size(1000, 600);
  textAlign(CENTER, CENTER);
  
  buttons = new Button[6];
  buttons[0] = new Button("Cafe Wall", Colors.PURPLE);
  buttons[1] = new Button("Lilac Chaser", Colors.PURPLE);
  buttons[2] = new Button("Hering Illusion", Colors.PURPLE);
  buttons[3] = new Button("Gray gradient", Colors.PURPLE);
  buttons[4] = new Button("Stepping feet", Colors.PURPLE);
  buttons[5] = new Button("Cubes", Colors.PURPLE);
  
  cw = new CafeWall(600, 250, 4);
  lc = new LilacChaser(300);
  hr = new Hering(600, 250);
  gg = new GrayGradient(600, 250);
  sf = new SteppingFeet(600, 250);
  cu = new Cubes(300, 250);
  
  actionButton = new Button("Action", Colors.GOLDEN);
}

void draw() {
  background(Colors.GRAY);  // why does this smooth text?
  fill(255);
  textSize(36);
  text("Visual Computing - Optical Illusions", width/2, 40);
  textSize(16);
  text("José David Nieto, Rubén Camilo Buelvas\nUniversidad Nacional de Colombia", width/2, 100);
  
  selectIllusion(mode);
  for(int i = 0; i < buttons.length; i++) {
    buttons[i].display(0, buttonOffset+40*i, 220, 30);
  }
  actionButton.display(width/2-50, height-100, 250, 50);
}

void mouseClicked() {  
  for(int i = 0; i < buttons.length; i++) {
    if(buttons[i].update())  mode = i;
  }
  
  if(actionButton.update())
    selectAction(mode);  
}

void selectIllusion(int c) {
  switch (c) {
    case 0:
      cw.display(300, 200);
      break;
    case 1:
      lc.display(420, 180);
      break;
    case 2:
      hr.display(300, 200);
      break;
    case 3:
      gg.display(300, 200);
      break;
    case 4:
      sf.display(300, 200);
      break;
    case 5:
      cu.display(420, 200);
      break;
  }
}

void selectAction(int m) {
  switch(m) {
    case 0:
      cw.action();
      break;
    case 1:
      lc.action();
      break;
    case 2:
      hr.action();
      break;
    case 3:
      gg.action();
      break;
    case 4:
      sf.action();
      break;
    case 5:
      cu.action();
      break;
  }
}
