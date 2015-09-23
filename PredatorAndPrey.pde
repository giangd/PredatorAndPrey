Predator pred = new Predator();
Prey[] prey = new Prey[50];
void setup() {
  size(500, 500); 
  noStroke();
  for (int i = 0; i < prey.length; i ++) {
    prey[i] = new Prey((int)random(width), (int)random(height), (int)random(5, 50));
  }
}

void draw() {
  background(0);
  pred.move();
  pred.display();
  for (int i = 0; i < prey.length; i ++) {
    if (prey[i].dead == false) {
      prey[i].display();
      prey[i].die();
    }
  }
  if (pred.size > 10 && (frameCount%60 == 0)) {
    pred.size -= pred.size*0.01;
  }
}

void keyPressed() {
  if (keyCode == UP) {
    pred.up = true;
  } else if (keyCode == DOWN) {
    pred.down = true;
  } else if (keyCode == RIGHT) {
    pred.right = true;
  } else if (keyCode == LEFT) {
    pred.left = true;
  }
}

void keyReleased() {
  if (keyCode == UP) {
    pred.up = false;
  } else if (keyCode == DOWN) {
    pred.down = false;
  } else if (keyCode == RIGHT) {
    pred.right = false;
  } else if (keyCode == LEFT) {
    pred.left = false;
  }
}

class Predator {
  int x = 250;
  int y = 250;
  boolean up, down, right, left;
  int size = 10;
  int speed = 3;

  Predator() {
  }

  void move() {
    if (up || down) {
      if (up && down) {
        y += 0;
      } else if (up) {
        y -= speed;
      } else if (down) {
        y += speed;
      }
    }
    if (left || right) {
      if (left && right) {
        x += 0;
      } else if (left) {
        x -= speed;
      } else if (right) {
        x += speed;
      }
    }
  }

  void display() {
    fill(255, 0, 0);
    ellipse(x, y, size, size);
  }
}

class Prey {
  int x;
  int y;
  int size;
  boolean dead = false;

  Prey(int tempX, int tempY, int tempSize) {
    x = tempX;
    y = tempY;
    size = tempSize;
  }

  void die() {
    if (size < pred.size) {
      if (dist(x, y, pred.x, pred.y) <= size/2+pred.size/2) {
        dead = true;
        pred.size += 5;
      }
    }
  }

  void display() {
    fill(0, 255, 0);
    ellipse(x, y, size, size);
  }
}
