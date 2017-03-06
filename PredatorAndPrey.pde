int startSize = 15;
Predator pred = new Predator(790, 250, startSize, color(0,0,255));
Predator pred2 = new Predator(10, 250, startSize, color(255,0,0));
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
  background(100);
  for (int i = 0; i < prey.length; i ++) {
      prey[i].run();
  }
  pred.run();
  pred2.run();
  die();
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
    pred2.up = true;
  } else if (key == 's') {
    pred2.down = true;
  } else if (key == 'd') {
    pred2.right = true;
  } else if (key == 'a') {
    pred2.left = true;
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
    pred2.up = false;
  } else if (key == 's') {
    pred2.down = false;
  } else if (key == 'd') {
    pred2.right = false;
  } else if (key == 'a') {
    pred2.left = false;
  } 
}

class Predator {
  float x = 250;
  float y = 250;
  boolean up, down, right, left;
  float size = 15;
  float speed = 1.5;
  color myColor;
  color deadColor = color(200);
  color currentColor = myColor;
  boolean dead = false, changeBack = false;
  float timeDied;

  Predator(int tempX, int tempY, float tempSize, color tempMyColor) {
    x = tempX;
    y = tempY;
    size = tempSize;
    myColor = tempMyColor;
    currentColor = myColor;
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
  
  void decSize() {
    this.speed = (20/this.size)+1.5;  
  }
  
  void respawn() {
    if (this.dead) {
      x = width/2;
      y = height/2;
      this.size = 15;
      this.currentColor = this.deadColor;
      this.dead = false;
      this.changeBack = true;
    } else if (this.changeBack && frameCount > this.timeDied+250) {
      this.currentColor = this.myColor;
      this.changeBack = false;
    }
  }

  void display() {
    fill(currentColor);
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
    if (size > startSize*50) {
        size -= size*0.9;
    }
  }
  
  void run() {
    move();
    shrink();
    display();
    decSize();
    respawn();
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
    if (size <= pred2.size && dist(x, y, pred2.x, pred2.y) <=  pred2.size/2) {
      dead = true;
      age = frameCount;
      pred2.size += size/5;
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

void die() {
  //pred is blue
  //pred2 is red
  if (!pred.changeBack && pred.size < pred2.size && dist(pred.x, pred.y, pred2.x, pred2.y) <=  pred2.size/2) {
   pred.dead = true;  
   pred.timeDied = frameCount;
  }
  if (!pred2.changeBack && pred2.size < pred.size && dist(pred2.x, pred2.y, pred.x, pred.y) <=  pred.size/2) {
   pred2.dead = true;
   pred2.timeDied = frameCount;
  }
  //if (pred.dead) {
  //  print("blue is dead"); 
  //}
  //if (pred2.dead) {
  //  print("red is dead"); 
  //}
}
