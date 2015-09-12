//int collisions = 0;
color bgColor = color(0);
int bubbleNum = 500;
boolean showRect = false;
int rectW = 100; //default
int rectH = 20;
float rectR = 0;

//Bubble bob;
//Bubble sue;
//Bubble sue2;
//Bubble sue3;
//Bubble sue4;
//Bubble sue5;
Bubble[] bobs = new Bubble[bubbleNum];

void setup() {
  size(1000, 500);
  //bob = new Bubble(width/2, height/2);
  //sue = new Bubble(width/2+-10, height/2);
  //sue2 = new Bubble(width/2+10, height/2);

  //sue3 = new Bubble(width/2, height/2+10);
  //sue4 = new Bubble(width/2+-10, height/2+10);
  //sue5 = new Bubble(width/2+10, height/2+10);
  for (int i = 0; i < bobs.length; i++) {
    //bobs[i] = new Bubble(width/2, height);
    bobs[i] = new Bubble((int)(Math.random()*width+1), (int)(Math.random()*height+1));
  }
  frameRate(60);
  noStroke();
}   

void draw() {
  //collisions = 0;
  //println(frameRate);
  background(bgColor);
  //translate(mouseX+rectW*2-rectW,mouseY-rectH/2);
  //rotate(rectR);
  
  if (showRect) {
    fill(bobs[0].myColor);
    rect(mouseX-rectW/2, mouseY-rectH/2, rectW, rectH);
  }
  //resetMatrix();
  
  for (int i = 0; i < bubbleNum; i++) {
   bobs[i].run();
  }
  
  //println(frameRate);
  //println(frameCount+": "+collisions);
}  

class Bubble {
  int x, y, age;
  int reviveTime = 10; //time until revives (seconds) -- its based on fps so its not accurate if you have low frames
  int radius = 30;
  color myColor = color(255);
  float speed = 1.0;

  double rand;
  float upChance = 0.50;
  float downChance = 0.50;
  float leftChance = 0.50;
  float rightChance = 0.50;
  boolean popped = false;

  Bubble(int tempX, int tempY) {
    x = tempX;
    y = tempY;
  }

  void move() {
    upChance = 0.10; //explained somewhere below
    downChance = 0.35;
    leftChance = 0.25;
    rightChance = 0.25;

    //check for collisions
    if (get(x-radius/2, y) == color(myColor) && get(x+radius/2, y) == color(myColor)) { //if collisions on left AND right -- kept getting bug that made bubbles sometimes get past rect
      rightChance = 0.00;
      leftChance = 0.00;
    } else {
      if (get(x-radius/2, y) == color(myColor)) { //left
        //collisions += 1;
        rightChance = 0.50;
        leftChance = 0.0;
      }
      if (get(x+radius/2, y) == color(myColor)) { //right
        //collisions += 1;
        leftChance = 0.50;
        rightChance = 0.00;
      }
    }
    if (get(x, y-radius/2) == color(myColor) && get(x, y+radius/2) == color(myColor)) { //up AND down
      downChance = 0.00;
      upChance = 0.00;
    } else {
      if (get(x, y-radius/2) == color(myColor)) { //up
        //collisions += 1;
        downChance = 0.50;
        upChance = 0.00;
      } else if (get(x, y+radius/2) == color(myColor)) { //down
        //collisions += 1;
        upChance = 0.50;
        downChance = 0.00;
      }
    }

     /*
     |-----*------|
           ^ 
     think of rand as being
     anywhere on this line
     
     |===---------|
       ^30
     |###====------|
           ^40 %
     |#######======|
                ^60 %
     */
    rand = Math.random();
    if (rand < upChance) { //think of a number line with it filling up
      y -= speed;
    } else if (rand < upChance+downChance) {
      y += speed;
    } else if (rand < upChance+downChance+leftChance) {
      x -= speed;
    } else if (rand < upChance+downChance+leftChance+rightChance) {
      x += speed;
    }

    if (y < 0-radius) { //loop around screen
      y = height+radius/2;
    } else if (y > height+radius) {
      y = 0-radius/2;
    }
    if (x < 0-radius) {
      x = width+radius/2;
    } else if (x > width+radius) {
      x = 0-radius/2;
    }
  }

  void pop() {
    if (mouseX > x-radius/2 && mouseX < x+radius/2 && mouseY > y-radius/2 && mouseY < y+radius/2) {
      if (mousePressed) {
        popped = true;
        age = frameCount;
      }
    }
  }

  void revive() {
    if (frameCount > age + (int)frameRate*reviveTime) {
      popped = false;
      x = (int)(Math.random()*width+1);
      y = height+radius/2;
    }
  }

  void show() {
    fill(myColor);
    ellipse(x, y, radius, radius);
  }

  void run() {
    if (!popped) {
      show();
      move();
      pop();
    } else {
      revive();
    }
  }
}

void mousePressed() { //change between cursor and rect mode
  if (mouseButton == RIGHT) {
    showRect = true;
    noCursor();
  } else if (mouseButton == LEFT) {
    showRect = false;
    cursor();
  }
}

void keyPressed() { //change rect dimensions
  if (keyCode == UP) {
    rectH = constrain(rectH+=10, 10, height);
  } else if (keyCode == DOWN) {
    rectH = constrain(rectH-=10, 10, height);
  } else if (keyCode == LEFT) {
    rectW = constrain(rectW-=10, 10, width);
  } else if (keyCode == RIGHT) {
    rectW = constrain(rectW+=10, 10, width);
  } else if (key == 'r') {
    rectR += 0.1;
  }
}

// int bacteriaNum = 100;
// Bacteria bob;
// Bacteria[] bobs = new Bacteria[bacteriaNum];

// void setup() {
//   size(400, 400);
//   bob = new Bacteria(width/2, height/2);
//   for (int i = 0; i < bobs.length; i++) {
//     //bobs[i] = new Bacteria(width/2, height/2);
//     bobs[i] = new Bacteria((int)(Math.random()*width+1),(int)(Math.random()*height+1));
//   }
//   frameRate(60);
// }   

// void draw() {
//   background(0, 0, 0);
//   bob.move();
//   bob.show();
//   for (int i = 0; i < bacteriaNum; i++) {
//     bobs[i].move();
//     bobs[i].show();
//   }
// }  

// class Bacteria {
//   float x, y;
//   double rand;

//   float upChance = 0.50;
//   float downChance = 0.50;
//   float leftChance = 0.50;
//   float rightChance = 0.50;

//   float speed = 1.0;
//   float chanceInc = 0.15;

//   Bacteria(float tempX, float tempY) {
//     x = tempX;
//     y = tempY;
//   }

//   void move() {
//     upChance = 0.50;
//     downChance = 0.50;
//     leftChance = 0.50;
//     rightChance = 0.50;

//     if (mouseX > 0) {
//       if (x < mouseX) {
//         rightChance += chanceInc;
//         leftChance -= chanceInc;
//       } else if (x > mouseX) {
//         leftChance += chanceInc;
//         rightChance -= chanceInc;
//       }

//       if (y < mouseY) {
//         downChance += chanceInc;
//         upChance -= chanceInc;
//       } else if (y > mouseY) {
//         upChance += chanceInc;
//         downChance -= chanceInc;
//       }
//     }

//     rand = Math.random();

//     if (rand < upChance) {
//       y -= speed;
//     } else if (rand < upChance+downChance) {
//       y += speed;
//     }

//     if (rand < leftChance) {
//       x -= speed;
//     } else if (rand < leftChance+rightChance) {
//       x += speed;
//     }
//   }

//   void show() {
//     ellipse(x, y, 10, 10);
//   }
// }  