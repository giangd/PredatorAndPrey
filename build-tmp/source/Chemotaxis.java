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
//also, checking using != bgColor doesnt work if the bubble goes out of the screen -- apparently shapes drawn outside the screen are black??
//pixel[] crashes program when it checks outside of screen or for some other reason


ArrayList<Barrier> barriers = new ArrayList<Barrier>();
ArrayList<Bubble> bubbles = new ArrayList<Bubble>();
int bgColor = color(55, 93, 129);

// int bubbleNum = 50;

int rectColor = color(237, 128, 0);


// Bubble[] bobs = new Bubble[bubbleNum]; //not using array instead im using the arraylist
// int mode = 0; //0 make bubbles, 1 draw
boolean checkForCollision = false; // not documented on the github website since it works so slow on browsers it might crash, but you can turn it on by pressing c
// int bubbleSize = 30;
int bubbleSizeMax2 = 60;
int bubbleSizeMin = 20;
int transparency = 200;


int bubbleSizeMax = bubbleSizeMax2-bubbleSizeMin;//this is bc of the way randEvenNum is
public void setup() {
  size(1000, 500);
  noStroke();
}   

public void draw() {
  background(bgColor);
  
  // for (int i = 0; i < barriers.size(); i ++) {
  //   Barrier bar = barriers.get(i);
  //   bar.show();
  // }
  
  for (int i = 0; i < bubbles.size(); i ++) {
    Bubble bub = bubbles.get(i);
    bub.run();
  }
}  

public int randEvenNum() {
  int randEvenNum = (int)(Math.random()*bubbleSizeMax+1)+bubbleSizeMin;
  while(randEvenNum % 2 != 0) {
    randEvenNum = (int)(Math.random()*bubbleSizeMax+1)+bubbleSizeMin;
  }
  return randEvenNum;
}

class Bubble {
  int x, y, age;
  int reviveTime = 10; //time until revives (seconds) -- its based on fps so its not accurate if you have low frames
  int myColor = color(196, 215, 237, transparency);
  int speed = 1;
  int radius; //has to be even

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
  
  Bubble(int tempX, int tempY, int tempRadius) {
    x = tempX;
    y = tempY;
    radius = tempRadius;
  }

  public void movement() {

    if (checkForCollision) {
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
    } else {
      leftChance = 0.25f; 
      rightChance = 0.25f;
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

    if (y < 0+radius/2) { 
      //y = height+radius/2;
      y = 0+radius/2;
    } else if (y > height-radius/2) {
      y = height-radius/2;
    }
    if (x < 0+radius/2) {
      // x = width+radius/2;
      x = 0+radius/2;
    } else if (x > width-radius/2) {
      // x = 0-radius/2;
      x = width-radius/2;
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
    //radius = bubbleSize;
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

// void mousePressed() { //change between cursor and rect mode
  // if (mouseButton == RIGHT) {
  //   // showRect = true;
  //   // noCursor();
  //   bubbles.add(new Bubble(mouseX,mouseY));
  // } else if (mouseButton == LEFT) {
  //   // showRect = false;
  //   // cursor();
  // }
//}

public void mouseDragged() {
  if (mouseButton == RIGHT) {
    bubbles.add(new Bubble(mouseX,mouseY,randEvenNum()));
  }
  //   if (mode == 0) {
  //     bubbles.add(new Bubble(mouseX,mouseY));


  //   } else {
  //     barriers.add(new Barrier(mouseX, mouseY));
  //     if (barriers.size() > 500) {
  //       barriers.remove(0);
  //     }
  //     showRect = false;
  //   }
  // } 
}

public void keyPressed() { //change rect dimensions
  // if (keyCode == UP) {
  //   rectH = constrain(rectH+=sizeInc, 5, height);
  // } else if (keyCode == DOWN) {
  //   rectH = constrain(rectH-=sizeInc, 5, height);
  // } else if (keyCode == LEFT) {
  //   rectW = constrain(rectW-=sizeInc, 5, width);
  // } else if (keyCode == RIGHT) {
  //   rectW = constrain(rectW+=sizeInc, 5, width);
  // } else if (key == 'r') {
  //   rectR += 0.1;
  // }
  // if (key == 'a') {
  //  rectX -= sizeInc;
  // } else if (key == 'd') {
  //  rectX += sizeInc;
  // } else if (key == 'w') {
  //  rectY -= sizeInc;
  // } else if (key == 'd') {
  //  rectY += sizeInc;
  // }
  // if (keyCode == UP) {
  //   bubbleSize = constrain(bubbleSize+=2, 2, height);
  // } else if (keyCode == DOWN) {
  //   bubbleSize = constrain(bubbleSize-=2, 2, height);
  // }
  // if (key == 'r') {
  //   for (int i = barriers.size()-1; i >= 0; i --) {
  //     barriers.remove(i);
  //   }
  //   // for (int i = 0; i < barriers.size(); i ++) {
  //   //   barriers.remove(i);
  //   // }
  // } else
  if (key == 'r') {
    for (int i = bubbles.size()-1; i >= 0; i --) {
      bubbles.remove(i);
    }
  } else if (key == 'c') {
    if (checkForCollision) {
      checkForCollision = false;
    } else {
      checkForCollision = true;
    }
  }

  // else if (key == 'd' ) {
  //   if (mode == 1) {
  //     mode = 0;
  //   } else {
  //     mode = 1;
  //   }
  // }

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
