Predator pred = new Predator(width/2, height/2, 20);
Prey[] prey = new Prey[200];
void setup() {
  size(1000, 1000); 
  noStroke();
  for (int i = 0; i < prey.length; i ++) {
    prey[i] = new Prey((int)random(width), (int)random(height), (int)random(pred.size-pred.size/2, pred.size+20));
  }
}

void draw() {
  background(0);
  for (int i = 0; i < prey.length; i ++) {
      prey[i].run();
  }
  pred.run();
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
  } else if (key == 'w') {
    pred.up = true;
  } else if (key == 's') {
    pred.down = true;
  } else if (key == 'd') {
    pred.right = true;
  } else if (key == 'a') {
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
  } else if (key == 'r') {
    for (int i = 0; i < prey.length; i ++) {
      // prey[i] = new Prey((int)random(width), (int)random(height), (int)random(pred.size-pred.size/2, pred.size+20));
      prey[i] = new Prey((int)random(width), (int)random(height), (int)random(10,50));
      prey[i].dead = false;
      pred.size = 20;
    }
  } else if (key == 'w') {
    pred.up = false;
  } else if (key == 's') {
    pred.down = false;
  } else if (key == 'd') {
    pred.right = false;
  } else if (key == 'a') {
    pred.left = false;
  } 
}

class Predator {
  int x = 250;
  int y = 250;
  boolean up, down, right, left;
  float size = 60;
  int speed = 2;

  Predator(int tempX, int tempY, float tempSize) {
    x = tempX;
    y = tempY;
    size = tempSize;
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

  void shrink() {
    if (size > 20) {
      size -= size*0.002;
    }
  }

  void run() {
    move();
    shrink();
    display();
  }
}

class Prey {
  int x;
  int y;
  float size;
  boolean dead = false;
  int age;
  int reviveTime = 5;
  int sizeRange = 40;

  Prey(int tempX, int tempY, int tempSize) {
    x = tempX;
    y = tempY;
    size = tempSize;
  }

  void die() {
    if (size < pred.size) {
      if (dist(x, y, pred.x, pred.y) <=  pred.size/2-size/2) {
        dead = true;
        age = frameCount;
        pred.size += 5;
      }
    }
  }
  
  void revive() {
    if (frameCount > age+reviveTime*60) {
      x = (int)random(width);
      y = (int)random(height);
      size = (int)random(10,50);
      dead = false;
    }
  }

  void display() {
    fill(0, 255, 0);
    ellipse(x, y, size, size);
  }

  void run() {
    if (!dead) {
      display();
      die();
    } else {
      revive(); 
    }
  }
}
