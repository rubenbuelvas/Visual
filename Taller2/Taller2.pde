int buttonOffset = 120;

CafeWall cw;

Button[] buttons;

void setup() {
  size(1200, 600);
  textAlign(CENTER, CENTER);
  
  buttons = new Button[7];
  buttons[0] = new Button("Cafe Wall", color(50));
  buttons[1] = new Button("Illusion 2", color(50));
  buttons[2] = new Button("Illusion 3", color(50));
  buttons[3] = new Button("Illusion 4", color(50));
  buttons[4] = new Button("Illusion 5", color(50));
  buttons[5] = new Button("Illusion 6", color(50));
  buttons[6] = new Button("Illusion 7", color(50));
  
  cw = new CafeWall(600, 250, 4);
}

void draw() {
  background(0);  // why does this smooth text?
  textSize(36);
  text("Visual Computing - Optical Illusions", width/2, 40);
  textSize(16);
  text("José David Nieto, Rubén Camilo Buelvas\nUniversidad Nacional de Colombia", width/2, 100);
  
  for(int i = 0; i < buttons.length; i++) {
    buttons[i].display(0, buttonOffset+40*i, 220, 30);
  }
  
  cw.display(400, 200);
}
