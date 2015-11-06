int startSize = 15;
Predator pred = new Predator(width/2, height/2, startSize);
Prey[] prey = new Prey[200];
void setup() {
  size(800, 500); 
  noStroke();
  for (int i = 0; i < prey.length; i ++) {
    prey[i] = new Prey((int)random(width), (int)random(height), (int)random(5, 40));
  }
  // for (int i = 0; i < prey.length; i ++) {
  //   prey.display();
  //   while (get(x,y) == myColor) {
  //     prey.x = (int)random(width);
  //     prey.y = (int)random(height);
  //   }
  // }
  
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
      prey[i] = new Prey((int)random(width), (int)random(height), (int)random(5,50));
      prey[i].dead = false;
      pred.size = 10;
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
  float x = 250;
  float y = 250;
  boolean up, down, right, left;
  float size = 60;
  float speed = 1.5;

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
    if (size > startSize) {
      size -= size*0.0018;
    }
    if (size > startSize*3) {
        size -= size*0.0001;
    }
    if (size > startSize*4) {
        size -= size*0.0003;
    }
    if (size > startSize*5) {
        size -= size*0.001;
    }
    if (size > startSize*10) {
        size -= size*0.9;
    }
  }

  void run() {
    move();
    shrink();
    display();
  }
}

class Prey {
  float x, y;
  float size;
  boolean dead = false;
  int age;
  int reviveTime = 5;
  int sizeRange = 40;
  color myColor = color(0,255,0);

  Prey(int tempX, int tempY, int tempSize) {
    x = tempX;
    y = tempY;
    size = tempSize;
  }

  void die() {
    if (size <= pred.size && dist(x, y, pred.x, pred.y) <=  pred.size/2) {
      dead = true;
      age = frameCount;
      pred.size += size/5;
    }
  }
  
  void revive() {
    if (frameCount > age+reviveTime*60) {
      x = (int)random(width);
      y = (int)random(height);
      size = (int)random(5,50);
      dead = false;
    }
  }

  void display() {
    fill(myColor);
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
