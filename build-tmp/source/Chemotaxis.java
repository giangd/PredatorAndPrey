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

public class Chemotaxis extends PApplet {

//int collisionNum = 0;
//program doesnt run in github or file and if it works its very slow
//also checking using != bgColor doesnt work if the bubble goes out of the screen apparently shapes drawn outside the screen are black??
//pixel[] crashes program when it checks outside of screen

ArrayList<Barrier> barriers = new ArrayList<Barrier>();
ArrayList<Bubble> bubbles = new ArrayList<Bubble>();
int bgColor = color(55, 93, 129);
int test;
int bubbleNum = 50;
boolean showRect = false;
int rectW = 100; //default
int rectH = 20;
int rectX = 500;
int rectY = 250;
float rectR = 0;
int rectColor = color(237, 128, 0);
int sizeInc = 10;
Bubble bob;
//Bubble sue;
//Bubble sue2;
//Bubble sue3;
//Bubble sue4;
//Bubble sue5;
Bubble[] bobs = new Bubble[bubbleNum];
int mode = 0; //make bubbles
Barrier modelBarrier = new Barrier(-100,0);
public void setup() {
  size(1000, 500);
  //test = new Barrier(100, 100);
  bob = new Bubble(width/2+1, height/2);
  //sue = new Bubble(width/2+-10, height/2);
  //sue2 = new Bubble(width/2+10, height/2);

  //sue3 = new Bubble(width/2, height/2+10);
  //sue4 = new Bubble(width/2+-10, height/2+10);
  //sue5 = new Bubble(width/2+10, height/2+10);
  for (int i = 0; i < bobs.length; i++) {
    //bobs[i] = new Bubble(width/2+(int)(Math.random()*101)-50, height-50);
    bobs[i] = new Bubble(width/2+(int)(Math.random()*101)-50,height);
    //bobs[i] = new Bubble((int)(Math.random()*width+1), (int)(Math.random()*height+1));
  }
  // frameRate(60);
  noStroke();
}   

public void draw() {
  //collisions = 0;
  //println(frameRate);
  background(bgColor);

  // if (showRect) {
  //   fill(rectColor);
  //   //fill(bob.myColor);
  //   rect(mouseX-rectW/2, mouseY-rectH/2, rectW, rectH);
  //   //rect(rectX, rectY, rectW, rectH);
  //   //rect(width/2-100,height/2,200,200);
  // }
  
  
  for (int i = 0; i < barriers.size(); i ++) {
    Barrier bar = barriers.get(i);
    bar.show();
  }
  
  for (int i = 0; i < bubbles.size(); i ++) {
    Bubble bub = bubbles.get(i);
    bub.run();
  }

  // bob.run();

  // for (int i = 0; i < bubbleNum; i++) {
  //   //loadPixels();
  //   bobs[i].run();
  //   //bobs[i].display();
  // }

  println(frameRate);
  // for (Bubble bobBubbles: bobs) {
  //   bobBubbles.run();
  // }
  //println(frameRate);
  //println(frameCount+": "+collisions);
  if (mode == 1) {
    stroke(100,50,50);
    fill(rectColor);
    ellipse(mouseX,mouseY,modelBarrier.radius,modelBarrier.radius);
    noStroke();
  }
}  

class Bubble {
  int x, y, age;
  int reviveTime = 10; //time until revives (seconds) -- its based on fps so its not accurate if you have low frames
  int myColor = color(196, 215, 237);
  int speed = 1;
  int radius = 40; //has to be even

  double rand;
  float upChance;
  float downChance;
  float leftChance;
  float rightChance;
  boolean popped = false;
  boolean downCollision;
  boolean upCollision;
  boolean leftCollision;
  boolean rightCollision;
  
  Bubble(int tempX, int tempY) {
    x = tempX;
    y = tempY;
  }

  public void movement() {
    
    //check for collisions
    //idk why but checking for left and up collisions work with x-1-radius/2 but not x-radius/2 while the other ones DO work with x+radius/2
    //shouldve just used != bgColor and not have to check 4 times --but then they wouldnt go oustide screen and loop around 
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

    // if ((get(x-1-radius/2, y) != color(bgColor) && get(x+radius/2, y) != color(bgColor)) ||
    //   (get(x-1-radius/2, y) != color(bgColor) && get(x+radius/2, y) != color(bgColor))) { //if collisions on left AND right -- kept getting bug that made bubbles sometimes get past rect
    //   //println("LEFT&RIGHT " + frameCount);
    //   rightChance = 0.00;
    //   leftChance = 0.00;
    // } else {
    //   if (get(x-1-radius/2, y) != color(bgColor)) { //left
    //     //collisions += 1;
    //     //println("LEFT " + frameCount); 
    //     rightChance = 0.50;
    //     leftChance = 0.0;
    //   }
    //   if (get(x+radius/2, y) != color(bgColor)) { //right
    //     //collisions += 1;
    //     //println("RIGHT "+frameCount); 
    //     leftChance = 0.50;
    //     rightChance = 0.00;
    //   }
    // }
    // if ((get(x, y-1-radius/2) != color(bgColor) && get(x, y+radius/2) != color(bgColor)) ||
    //   (get(x, y-1-radius/2) == color(255) && get(x, y+radius/2) != color(bgColor))) { //up AND down
    //   //println("UP&DOWN" + frameCount); 
    //   downChance = 0.00;
    //   upChance = 0.00;
    // } else {
    //   if (get(x, y-1-radius/2) != color(bgColor) || get(x, y-1-radius/2) == color(255)) { //up
    //     //println("UP" + frameCount); 
    //     //collisions += 1;
    //     downChance = 0.50;
    //     upChance = 0.00;
    //   } else if (get(x, y+radius/2) != color(bgColor) || get(x, y+radius/2) == color(255)) { //down
    //     //println("DOWN" + frameCount); 
    //     //collisions += 1;
    //     upChance = 0.50;
    //     downChance = 0.00;
    //   }
    // }
    //                    cant use pixels[] bc program crashes when it checks outside of screen 
    // pixels[y*width+x]
    
    // if (leftCollision || rightCollision) {
    //   if (leftCollision && rightCollision) {
    //     rightChance = 0.00;
    //     leftChance = 0.00;
    //   } else if (leftCollision) {
    //     rightChance = 0.50;
    //     leftChance = 0.0;
    //   } else if (rightCollision) {
    //     leftChance = 0.50;
    //     rightChance = 0.00;
    //   }
    // } else {
    //   leftChance = 0.25;
    //   rightChance = 0.25;
    // }
    
    // downCollision = pixels[(y+radius/2)*width+x] != color(bgColor);
    // upCollision = pixels[(y-1-radius/2)*width+x] != color(bgColor);
    // leftCollision = pixels[y*width+(x-1-radius/2)]  != color(bgColor);
    // rightCollision = pixels[y*width+(x+radius/2)] != color(bgColor);

    downCollision = get(x,y+radius/2) != color(bgColor);
    upCollision = get(x,y-1-radius/2) != color(bgColor);
    leftCollision = get(x-1-radius/2, y) != color(bgColor);
    rightCollision = get(x+radius/2, y) != color(bgColor);

    if (leftCollision || rightCollision) {
      if (leftCollision && rightCollision) {
        //println(frameCount + " LEFT&RIGHT");
        rightChance = 0.00f;
        leftChance = 0.00f;
      } else if (rightCollision) {
        //println(frameCount + " RIGHT");
        leftChance = 0.50f;
        rightChance = 0.00f;
      } else {
        //println(frameCount + " LEFT");
        rightChance = 0.50f;
        leftChance = 0.00f;
      }
    } else {
      leftChance = 0.25f;
      rightChance = 0.25f;
    }
    
    if (upCollision || downCollision) {
      if (upCollision && downCollision) {
        //println(frameCount + " P&DOWN");
        upChance = 0.00f;
        downChance = 0.00f;
      } else if (downCollision) {
        //println(frameCount + " DOWN");
        upChance = 0.50f;
        downChance = 0.0f;
      } else {
        //println(frameCount + " UP");
        downChance = 0.50f;
        upChance = 0.00f;
      }
    }  else {
      upChance = 0.40f;
      downChance = 0.10f;
    }

    rand = Math.random();
    if (rand < upChance) {
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

  public void pop() {
    if (mousePressed && mouseButton == LEFT) {
      if (mouseX > x-radius/2 && mouseX < x+radius/2 && mouseY > y-radius/2 && mouseY < y+radius/2) {
        popped = true;
        age = frameCount;
      }
    }
  }

  public void revive() {
    if (frameCount > age + 60*reviveTime) {
      popped = false;
      //x = (int)(Math.random()*width+1);
      x = width/2;
      y = height+radius/2;
    }
  }

  public void display() {
    fill(myColor);
    ellipse(x, y, radius, radius);
  }

  public void run() {
    if (!popped) {
      display();
      movement();
      pop();
    } else {
      //revive();
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

  public void show() {
    fill(rectColor);
    ellipse(x, y, radius, radius);
  }
}

public void mousePressed() { //change between cursor and rect mode
  // if (mouseButton == RIGHT) {
  //   // showRect = true;
  //   // noCursor();
  //   bubbles.add(new Bubble(mouseX,mouseY));
  // } else if (mouseButton == LEFT) {
  //   // showRect = false;
  //   // cursor();
  // }
  if (mode == 0) {
      bubbles.add(new Bubble(mouseX,mouseY));
  }
}
public void mouseDragged() {
  if (mouseButton == RIGHT) {
    if (mode == 0) {
      bubbles.add(new Bubble(mouseX,mouseY));
    } else {
      barriers.add(new Barrier(mouseX, mouseY));
      if (barriers.size() > 500) {
        barriers.remove(0);
      }
      showRect = false;
    }
  } 
}

public void keyPressed() { //change rect dimensions
  if (keyCode == UP) {
    rectH = constrain(rectH+=sizeInc, 5, height);
  } else if (keyCode == DOWN) {
    rectH = constrain(rectH-=sizeInc, 5, height);
  } else if (keyCode == LEFT) {
    rectW = constrain(rectW-=sizeInc, 5, width);
  } else if (keyCode == RIGHT) {
    rectW = constrain(rectW+=sizeInc, 5, width);
  } else if (key == 'r') {
    rectR += 0.1f;
  }
  // if (key == 'a') {
  //  rectX -= sizeInc;
  // } else if (key == 'd') {
  //  rectX += sizeInc;
  // } else if (key == 'w') {
  //  rectY -= sizeInc;
  // } else if (key == 'd') {
  //  rectY += sizeInc;
  // }
  if (key == 'r') {
    for (int i = barriers.size()-1; i >= 0; i --) {
      barriers.remove(i);
    }
    // for (int i = 0; i < barriers.size(); i ++) {
    //   barriers.remove(i);
    // }
  } else if (key == 't') {
    for (int i = bubbles.size()-1; i >= 0; i --) {
      bubbles.remove(i);
    }
  }  else if (key == 'd') {
    if (mode == 1) {
      mode = 0;
    } else {
      mode = 1;
    }
  }

} 


// int bacteriaNum = 1000;
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
//   bob.display();
//   for (int i = 0; i < bacteriaNum; i++) {
//     bobs[i].move();
//     bobs[i].display();
//   }
//   println(frameRate);
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
//     upChance = 0.25;
//     downChance = 0.25;
//     leftChance = 0.25;
//     rightChance = 0.25;

    

//     rand = Math.random();

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


//     // if (rand < upChance) {
//     //   y -= speed;
//     // } else if (rand < upChance+downChance) {
//     //   y += speed;
//     // } else if (rand < leftChance + upChance+downChance) {
//     //   x -= speed;
//     // } else if (rand < leftChance+rightChance+upChance+downChance) {
//     //   x += speed;
//     // }

//     if (rand < upChance) {
//       y -= speed;
//     } else if (rand < upChance+downChance) {
//       y += speed;
//     } else if (rand < upChance+downChance+leftChance) {
//       x -= speed;
//     } else if (rand < upChance+downChance+leftChance+rightChance) {
//       x += speed;
//     }
//   }

//   void display() {
//     ellipse(x, y, 10, 10);
//   }
// 
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Chemotaxis" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
