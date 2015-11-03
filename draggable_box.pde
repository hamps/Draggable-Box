float preX;
float preY;
Box[] boxes;

void setup() { 
  size(1345, 679);
  noStroke();
  int num = 8;
  float size = 80;
  float distance = 10;
  // Create and align a box array
  boxes = new Box[num];
  for (int i = 0; i < num; i++) {
    boxes[i] = new Box(200 + i * (distance + size), 200, size, size);
  }
}

void draw() {
  background(255);
  for (int i = 0; i < boxes.length; i++) {
    boxes[i].checkOver(mouseX, mouseY);
  }
}

class Box {
  private float bx;
  private float by;
  private float bWidth;
  private float bHeight;
  public boolean over;
  public boolean locked;
  
  Box(float nx, float ny, float nw, float nh) {
    bx = nx;
    by = ny;
    bWidth = nw;
    bHeight = nh;
    display();
  }
  
  void checkOver(float cx, float cy) {
    if (cx > bx && cx < bx + bWidth && cy > by && cy < by + bHeight) {
      over = true;
      if (locked) {
        fill(214, 69, 65);
        display();
      }
      else {
        fill(236);
        display();
      }
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
  
  private void display() {
    rect(bx, by, bWidth, bHeight);
  }
}

void mousePressed() {
  for (int i = 0; i < boxes.length; i++) {
    if (boxes[i].over) {
      preX = mouseX;
      preY = mouseY;
      boxes[i].locked = true;
    }
  }
}

void mouseReleased() {
  for (int i = 0; i < boxes.length; i++) {
    if (boxes[i].locked) {
      boxes[i].locked = false;
    }
  }
}

void mouseDragged() {
  for (int i = 0; i < boxes.length; i++) {
    if (boxes[i].over && boxes[i].locked) {
      boxes[i].move(mouseX - preX, mouseY - preY);
      preX = mouseX;
      preY = mouseY;
    }
  }
}