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

int bubbleNum = 100;
Bubble bob;
Bubble[] bobs = new Bubble[bubbleNum];

public void setup() {
  size(400, 400);
  bob = new Bubble(width/2, height/2);
  for (int i = 0; i < bobs.length; i++) {
    //bobs[i] = new bubble(width/2, height/2);
    bobs[i] = new Bubble((int)(Math.random()*width+1),(int)(Math.random()*height+1));
  }
  frameRate(60);
}   

public void draw() {
  background(0, 0, 0);
  bob.move();
  bob.show();
  for (int i = 0; i < bubbleNum; i++) {
    bobs[i].move();
    bobs[i].show();
  }
}  

class Bubble {
  float x, y;
  double rand;
  int radius = 30;
  float upChance = 0.50f;
  float downChance = 0.50f;
  float leftChance = 0.50f;
  float rightChance = 0.50f;

  float speed = 1.0f;
  float chanceInc = 0.15f;

  Bubble(float tempX, float tempY) {
    x = tempX;
    y = tempY;
  }

  public void move() {
    upChance = 0.25f;
    downChance = 0.25f;
    leftChance = 0.25f;
    rightChance = 0.25f;
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
  
  }
  public void show() {
    ellipse(x, y, radius, radius);
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
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Chemotaxis" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
