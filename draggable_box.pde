float preX;
float preY;
BoxList boxList;

void setup() { 
  size(1345, 679);
  noStroke();
  int num = 8;
  float size = 80;
  float distance = 10;
  float margin = 200;
  boxList = new BoxList(num);
  for (int i = 0; i < num; i++) {
    boxList.add(new Box(margin + i * (size + distance), margin, size, size));
  }
}

void draw() {
  background(255);
  while (boxList.hasNext()) {
    boxList.next().checkOver(mouseX, mouseY);
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
  
  public void checkOver(float cx, float cy) {
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
  
  public void move(float mx, float my) {
    bx += mx;
    by += my;
  }
  
  private void display() {
    rect(bx, by, bWidth, bHeight);
  }
}

class BoxList {
  private Box[] boxes;
  private int last = 0;
  private int index = 0;
  
  BoxList(int boxCount) {
    boxes = new Box[boxCount];
  }
  
  public void add(Box box) {
    boxes[last] = box;
    last++;
  }
  
  public boolean hasNext() {
    print(index);
    if (index < last) {
      return true;
    } else {
      index = 0;
      return false;
    }
  }
  
  public Box next() {
    Box box = boxes[index];
    index++;
    return box;
  }
}

void mousePressed() {
  while (boxList.hasNext()) {
    Box box = boxList.next();
    if (box.over) {
      preX = mouseX;
      preY = mouseY;
      box.locked = true;
    }
  }
}

void mouseReleased() {
  while (boxList.hasNext()) {
    Box box = boxList.next();
    if (box.locked) {
      box.locked = false;
    }
  }
}

void mouseDragged() {
  while (boxList.hasNext()) {
    Box box = boxList.next();
    if (box.over && box.locked) {
      box.move(mouseX - preX, mouseY - preY);
      preX = mouseX;
      preY = mouseY;
    }
  }
}