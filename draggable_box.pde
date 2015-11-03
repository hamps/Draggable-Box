float preX;
float preY;
Box[] boxes;

void setup() { 
  size(1345, 679);
  noStroke();
  int num = 3;
  boxes = new Box[num];
  for (int i = 0; i < num; i++) {
    boxes[i] = new Box(200, i * 100, 80, 80);
  }
}

void draw() {
  background(255);
  for (int i = 0; i < boxes.length; i++) {
    boxes[i].checkOver(mouseX, mouseY);
  }
}

class Box {
  float bx;
  float by;
  float bWidth;
  float bHeight;
  boolean over;
  boolean locked;
  
  Box(float nx, float ny, float nw, float nh) {
    bx = nx;
    by = ny;
    bWidth = nw;
    bHeight = nh;
    display();
  }
  void display() {
    rect(bx, by, bWidth, bHeight);
  }
  void checkOver(float cx, float cy) {
    if (cx > bx && cx < bx + bWidth && cy > by && cy < by + bHeight) {
      over = true;
      fill(214, 69, 65);
      display();
    } else {
      over = false;
      fill(236);
      display();
    }
  }
  void move(float mx, float my) {
    bx += mx;
    by += my;
  }
}

void mousePressed() {
  for (int i = 0; i < boxes.length; i++) {
    if (boxes[i].over) {
      preX = mouseX;
      preY = mouseY;
    }
  }
}

void mouseDragged() {
  for (int i = 0; i < boxes.length; i++) {
    if (boxes[i].over) {
      boxes[i].move(mouseX - preX, mouseY - preY);
      preX = mouseX;
      preY = mouseY;
    }
  }
}