//int collisionNum = 0;
//program doesnt run in github or file and if it works its very slow
//ArrayList<Barrier> barriers = new ArrayList<Barrier>();

color bgColor = color(55, 93, 129);
int bubbleNum = 10;
boolean showRect = false;
int rectW = 100; //default
int rectH = 20;
int rectX = 500;
int rectY = 250;
float rectR = 0;
color rectColor = color(237, 128, 0);
int sizeInc = 10;
Bubble bob;
//Bubble sue;
//Bubble sue2;
//Bubble sue3;
//Bubble sue4;
//Bubble sue5;
Bubble[] bobs = new Bubble[bubbleNum];
//Barrier test;
void setup() {
  size(1000, 500);
  //test = new Barrier(100, 100);
  bob = new Bubble(width/2+1, height/2);
  //sue = new Bubble(width/2+-10, height/2);
  //sue2 = new Bubble(width/2+10, height/2);

  //sue3 = new Bubble(width/2, height/2+10);
  //sue4 = new Bubble(width/2+-10, height/2+10);
  //sue5 = new Bubble(width/2+10, height/2+10);
  for (int i = 0; i < bobs.length; i++) {
    bobs[i] = new Bubble(width/2+(int)(Math.random()*101)-50, height);
    //bobs[i] = new Bubble((int)(Math.random()*width+1), (int)(Math.random()*height+1));
  }
  frameRate(30);
  noStroke();
}   

void draw() {
  //collisions = 0;
  //println(frameRate);
  background(bgColor);

  if (showRect) {
    fill(rectColor);
    //fill(bob.myColor);
    rect(mouseX-rectW/2, mouseY-rectH/2, rectW, rectH);
    //rect(rectX, rectY, rectW, rectH);
    //rect(width/2-100,height/2,200,200);
  }
  // for (int i = 0; i < barriers.size(); i ++) {
  //   Barrier bar = barriers.get(i);
  //   bar.show();
  // }
  bob.run();

  // for (int i = 0; i < bubbleNum; i++) {
  //   bobs[i].run();
  // }
  for (Bubble bobBubbles: bobs) {
    bobBubbles.run();
    //bobs[i] = new Bubble((int)(Math.random()*width+1), (int)(Math.random()*height+1));
  }

  //println(frameRate);
  //println(frameCount+": "+collisions);
}  

class Bubble {
  int x, y, age;
  int reviveTime = 10; //time until revives (seconds) -- its based on fps so its not accurate if you have low frames
  int radius = 30;
  color myColor = color(196, 215, 237);
  int speed = 1;

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

  void movement() {
    upChance = 0.35; //explained somewhere below
    downChance = 0.15;
    leftChance = 0.25;
    rightChance = 0.25;

    //check for collisions
    //idk why but checking for left and up collisions work with x-1-radius/2 but not x-radius/2 while the other ones DO work with x+radius/2
    //shouldve just used != bgColor and not have to check 4 times
    // if ((get(x-1-radius/2, y) == color(myColor) && get(x+radius/2, y) == color(myColor)) ||
    //   (get(x-1-radius/2, y) == color(rectColor) && get(x+radius/2, y) == color(rectColor)) ||
    //   (get(x-1-radius/2, y) == color(myColor) && get(x+radius/2, y) == color(rectColor)) ||
    //   (get(x-1-radius/2, y) == color(rectColor) && get(x+radius/2, y) == color(myColor))) { //if collisions on left AND right -- kept getting bug that made bubbles sometimes get past rect
    //   //println("LEFT&RIGHT " + frameCount);
    //   rightChance = 0.00;
    //   leftChance = 0.00;
    // } else {
    //   if ((get(x-1-radius/2, y) == color(myColor)) || (get(x-1-radius/2, y) == color(rectColor))) { //left
    //     //collisions += 1;
    //     //println("LEFT " + frameCount); 
    //     rightChance = 0.50;
    //     leftChance = 0.0;
    //   }
    //   if ((get(x+radius/2, y) == color(myColor)) || (get(x+radius/2, y) == color(rectColor))) { //right
    //     //collisions += 1;
    //     //println("RIGHT "+frameCount); 
    //     leftChance = 0.50;
    //     rightChance = 0.00;
    //   }
    // }
    // if ((get(x, y-1-radius/2) == color(myColor) && get(x, y+radius/2) == color(myColor)) ||
    //   (get(x, y-1-radius/2) == color(rectColor) && get(x, y+radius/2) == color(rectColor)) ||
    //   (get(x, y-1-radius/2) == color(myColor) && get(x, y+radius/2) == color(rectColor)) ||
    //   (get(x, y-1-radius/2) == color(rectColor) && get(x, y+radius/2) == color(myColor))) { //up AND down
    //   //println("UP&DOWN" + frameCount); 
    //   downChance = 0.00;
    //   upChance = 0.00;
    // } else {
    //   if ((get(x, y-1-radius/2) == color(myColor))|| (get(x, y-1-radius/2) == color(rectColor))) { //up
    //     //println("UP" + frameCount); 
    //     //collisions += 1;
    //     downChance = 0.50;
    //     upChance = 0.00;
    //   } else if ((get(x, y+radius/2) == color(myColor)) || (get(x, y+radius/2) == color(rectColor))) { //down
    //     //println("DOWN" + frameCount); 
    //     //collisions += 1;
    //     upChance = 0.50;
    //     downChance = 0.00;
    //   }
    // }

    if ((get(x-1-radius/2, y) != color(bgColor) && get(x+radius/2, y) != color(bgColor)) ||
      (get(x-1-radius/2, y) != color(bgColor) && get(x+radius/2, y) != color(bgColor))) { //if collisions on left AND right -- kept getting bug that made bubbles sometimes get past rect
      //println("LEFT&RIGHT " + frameCount);
      rightChance = 0.00;
      leftChance = 0.00;
    } else {
      if (get(x-1-radius/2, y) != color(bgColor)) { //left
        //collisions += 1;
        //println("LEFT " + frameCount); 
        rightChance = 0.50;
        leftChance = 0.0;
      }
      if (get(x+radius/2, y) != color(bgColor)) { //right
        //collisions += 1;
        //println("RIGHT "+frameCount); 
        leftChance = 0.50;
        rightChance = 0.00;
      }
    }
    if ((get(x, y-1-radius/2) != color(bgColor) && get(x, y+radius/2) != color(bgColor)) ||
      (get(x, y-1-radius/2) != color(bgColor) && get(x, y+radius/2) != color(bgColor))) { //up AND down
      //println("UP&DOWN" + frameCount); 
      downChance = 0.00;
      upChance = 0.00;
    } else {
      if (get(x, y-1-radius/2) != color(bgColor)) { //up
        //println("UP" + frameCount); 
        //collisions += 1;
        downChance = 0.50;
        upChance = 0.00;
      } else if (get(x, y+radius/2) != color(bgColor)) { //down
        //println("DOWN" + frameCount); 
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
      //x = (int)(Math.random()*width+1);
      x = width/2;
      y = height+radius/2;
    }
  }

  void display() {
    fill(myColor);
    ellipse(x, y, radius, radius);
  }

  void run() {
    if (!popped) {
      display();
      movement();
      pop();
    } else {
      revive();
    }
  }
}

class Barrier {
  int x, y;
  int radius = 20;
  Barrier(int tempX, int tempY) {
    x = tempX;
    y = tempY;
  }

  void show() {
    fill(rectColor);
    ellipse(x, y, radius, radius);
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
// void mouseDragged() {
//   if (mouseButton == RIGHT) {
//     barriers.add(new Barrier(mouseX, mouseY));
//     if (barriers.size() > 500) {
//       barriers.remove(0);
//     }
//     cursor();
//     showRect = false;
//   }
// }

void keyPressed() { //change rect dimensions
  if (keyCode == UP) {
    rectH = constrain(rectH+=sizeInc, 5, height);
  } else if (keyCode == DOWN) {
    rectH = constrain(rectH-=sizeInc, 5, height);
  } else if (keyCode == LEFT) {
    rectW = constrain(rectW-=sizeInc, 5, width);
  } else if (keyCode == RIGHT) {
    rectW = constrain(rectW+=sizeInc, 5, width);
  } else if (key == 'r') {
    rectR += 0.1;
  }
  if (key == 'a') {
   rectX -= sizeInc;
  } else if (key == 'd') {
   rectX += sizeInc;
  } else if (key == 'w') {
   rectY -= sizeInc;
  } else if (key == 'd') {
   rectY += sizeInc;
  }
  // if (key == 'r') {
  //   for (int i = barriers.size()-1; i >= 0; i --) {
  //     barriers.remove(i);
  //   }
  // } else if (key == 't') {
  //   for (int i = 0; i < bobs.length; i++) {
  //     bobs[i] = new Bubble(width/2+(int)(Math.random()*101)-50, height);
  //     //bobs[i] = new Bubble((int)(Math.random()*width+1), (int)(Math.random()*height+1));
  //   }
  // }
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
// 