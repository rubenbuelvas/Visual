import nub.primitives.*;
import nub.core.*;
import nub.processing.*;

// 1. Nub objects
Scene scene;
Node node;
Vector v1, v2, v3;
// timing
TimingTask spinningTask;
boolean yDirection;
// scaling is a power of 2
int n = 8;

// 2. Hints
boolean triangleHint = true;
boolean gridHint = true;
boolean debug = true;
boolean shadeHint = false;

// 3. Use FX2D, JAVA2D, P2D or P3D
String renderer = P2D;

// 4. Window dimension
int dim = 10;

void settings() {
  size(int(pow(2, dim)), int(pow(2, dim)), renderer);
}

void setup() {
  rectMode(CENTER);
  scene = new Scene(this);
  if (scene.is3D())
    scene.setType(Scene.Type.ORTHOGRAPHIC);
  scene.setRadius(width/2);
  scene.fit(1);

  // not really needed here but create a spinning task
  // just to illustrate some nub timing features. For
  // example, to see how 3D spinning from the horizon
  // (no bias from above nor from below) induces movement
  // on the node instance (the one used to represent
  // onscreen pixels): upwards or backwards (or to the left
  // vs to the right)?
  // Press ' ' to play it
  // Press 'y' to change the spinning axes defined in the
  // world system.
  spinningTask = new TimingTask(scene) {
    @Override
    public void execute() {
      scene.eye().orbit(scene.is2D() ? new Vector(0, 0, 1) :
        yDirection ? new Vector(0, 1, 0) : new Vector(1, 0, 0), PI / 100);
    }
  };

  node = new Node();
  node.setScaling(width/pow(2, n));

  // init the triangle that's gonna be rasterized
  randomizeTriangle();
}

void draw() {
  background(0);
  stroke(0, 255, 0);
  if (gridHint)
    scene.drawGrid(scene.radius(), (int)pow(2, n));
  if (triangleHint)
    drawTriangleHint();
  push();
  scene.applyTransformation(node);
  triangleRaster();
  pop();
}

// Implement this function to rasterize the triangle.
// Coordinates are given in the node system which has a dimension of 2^n
void triangleRaster() {
  // node.location converts points from world to node
  // here we convert v1 to illustrate the idea
  boolean clockwise = signedEdge(node.location(v3).x(), node.location(v3).y(), v1, v2) >= 0;
  
  if (debug) {
    push();
    noStroke();
    fill(255, 0, 0, 125);
    square(round(node.location(v1).x()), round(node.location(v1).y()), 1);
    pop();
  }  
  
  push();
  noStroke();
  fill(255, 0, 0, 125);
  for(int i = int(-1*pow(2, n-1)); i <= int(pow(2, n-1)); i++)  
    for(int j = int(-1*pow(2, n-1)); j <= int(pow(2, n-1)); j++) {
      float r12 = signedEdge(i, j, v1, v2);
      float r13 = signedEdge(i, j, v3, v1);
      float r23 = signedEdge(i, j, v2, v3);
      
      if((clockwise && r12 >= 0 && r13 >= 0 && r23 >= 0) || (!clockwise && r12 <= 0 & r13 <= 0 && r23 <= 0)) {
        
        int neighbors = 0;  
        
        int a = i-1;
        int b = j-1;
        
        for(int k=0; k<3; k++){
          for(int l=0; l<3; l++){
             r12 = signedEdge(a+k, b+l, v1, v2);
             r13 = signedEdge(a+k, b+l, v3, v1);
             r23 = signedEdge(a+k, b+l, v2, v3);
        
             if(!((clockwise && r12 >= 0 && r13 >= 0 && r23 >= 0) || (!clockwise && r12 <= 0 & r13 <= 0 && r23 <= 0))) {
               neighbors++;
             }
          }  
        }
        
       
        
        fill(getColor(i, j, neighbors));
        square(i, j, 1);
      }
  }
  pop();
}

color getColor(int i, int j, int n) {
  Vector node1 = node.location(v1);
  Vector node2 = node.location(v2);
  Vector node3 = node.location(v3);
  
  float r = dist(i, j, node1.x(), node1.y());
  float g = dist(i, j, node2.x(), node2.y());
  float b = dist(i, j, node3.x(), node3.y());
  
  float d12 = dist(node1.x(), node1.y(), node2.x(), node2.y());
  float d13 = dist(node1.x(), node1.y(), node3.x(), node3.y());
  float d23 = dist(node2.x(), node2.y(), node3.x(), node3.y());
  
  return color((255 - r * 255 / min(d12, d13)),
                (255 - g * 255 / min(d12, d23)),
                (255 - b * 255 / min(d13, d23)),
                (255/((n/3)+1)));
}

float signedEdge(float x, float y, Vector v0, Vector v1) {
  //System.out.println(px);
  float v0x = node.location(v0).x();
  float v0y = node.location(v0).y();
  float v1x = node.location(v1).x();
  float v1y = node.location(v1).y();
  
  return (v0y-v1y)*x + (v1x-v0x)*y + (v0x*v1y-v0y*v1x);
}

void randomizeTriangle() {
  int low = -width/2;
  int high = width/2;
  v1 = new Vector(random(low, high), random(low, high));
  v2 = new Vector(random(low, high), random(low, high));
  v3 = new Vector(random(low, high), random(low, high));
}

void drawTriangleHint() {
  push();

  if(shadeHint)
    noStroke();  
  else {
    strokeWeight(2);
    noFill();
  }
  beginShape(TRIANGLES);
  if(shadeHint)
    fill(255, 0, 0);
  else
    stroke(255, 0, 0);
  vertex(v1.x(), v1.y());
  if(shadeHint)
    fill(0, 255, 0);
  else
    stroke(0, 255, 0);
  vertex(v2.x(), v2.y());
  if(shadeHint)
    fill(0, 0, 255);
  else
    stroke(0, 0, 255);
  vertex(v3.x(), v3.y());
  endShape();

  strokeWeight(5);
  stroke(255, 0, 0);
  point(v1.x(), v1.y());
  text("1", v1.x(), v1.y());
  stroke(0, 255, 0);
  point(v2.x(), v2.y());
  text("2", v2.x(), v2.y());
  stroke(0, 0, 255);
  point(v3.x(), v3.y());
  text("3", v3.x(), v3.y());

  pop();
}

void keyPressed() {
  if (key == 'g')
    gridHint = !gridHint;
  if (key == 't')
    triangleHint = !triangleHint;
  if (key == 's')
    shadeHint = !shadeHint;
  if (key == 'd')
    debug = !debug;
  if (key == '+') {
    n = n < 7 ? n+1 : 2;
    node.setScaling(width/pow( 2, n));
  }
  if (key == '-') {
    n = n >2 ? n-1 : 7;
    node.setScaling(width/pow( 2, n));
  }
  if (key == 'r')
    randomizeTriangle();
  if (key == ' ')
    if (spinningTask.isActive())
      spinningTask.stop();
    else
      spinningTask.run();
  if (key == 'y')
    yDirection = !yDirection;
}
