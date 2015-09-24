import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class PredatorAndPrey extends PApplet {

Predator pred = new Predator(width/2, height/2, 20);
Prey[] prey = new Prey[50];
public void setup() {
  size(500, 500); 
  noStroke();
  for (int i = 0; i < prey.length; i ++) {
    prey[i] = new Prey((int)random(width), (int)random(height), (int)random(pred.size-pred.size/2, pred.size+20));
  }
}

public void draw() {
  background(0);
  for (int i = 0; i < prey.length; i ++) {
      prey[i].run();
  }
  pred.run();
}

public void keyPressed() {
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

public void keyReleased() {
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
  float size = 60;
  int speed = 2;

  Predator(int tempX, int tempY, float tempSize) {
    x = tempX;
    y = tempY;
    size = tempSize;
  }

  public void move() {
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

  public void display() {
    fill(255, 0, 0);
    ellipse(x, y, size, size);
  }

  public void shrink() {
    if (size > 10) {
      size -= size*0.001f;
    }
  }

  public void run() {
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

  public void die() {
    if (size < pred.size) {
      if (dist(x, y, pred.x, pred.y) <=  pred.size/2-size/2) {
        dead = true;
        age = frameCount;
        pred.size += 5;
      }
    }
  }
  
  public void revive() {
    if (frameCount > age+reviveTime*60) {
      x = (int)random(width);
      y = (int)random(height);
      size = (int)random(pred.size-sizeRange,pred.size-sizeRange);
    }
  }

  public void display() {
    fill(0, 255, 0);
    ellipse(x, y, size, size);
  }

  public void run() {
    if (!dead) {
      display();
      die();
    } else {
     revive(); 
    }
  }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "PredatorAndPrey" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
