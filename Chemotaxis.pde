int bubbleNum = 100;
Bubble bob;
Bubble[] bobs = new Bubble[bubbleNum];

void setup() {
  size(400, 400);
  bob = new Bubble(width/2, height/2);
  for (int i = 0; i < bobs.length; i++) {
    //bobs[i] = new bubble(width/2, height/2);
    bobs[i] = new Bubble((int)(Math.random()*width+1),(int)(Math.random()*height+1));
  }
  frameRate(60);
}   

void draw() {
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
  float upChance = 0.50;
  float downChance = 0.50;
  float leftChance = 0.50;
  float rightChance = 0.50;

  float speed = 1.0;
  float chanceInc = 0.15;

  Bubble(float tempX, float tempY) {
    x = tempX;
    y = tempY;
  }

  void move() {
    upChance = 0.25;
    downChance = 0.25;
    leftChance = 0.25;
    rightChance = 0.25;
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
  void show() {
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
