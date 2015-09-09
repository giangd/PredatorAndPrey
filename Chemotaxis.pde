Bacteria bob;

void setup() {
	size(400,400);
}   

void draw() {
	background(0,0,0);
	bob = new Bacteria(width/2,height/2);
	bob.move();
	bob.show();
	

}  

class Bacteria {
  int x, y;
  double rand;
  // float upChance = downChance = leftChance = rightChance = 0.25;
  float upChance = 0.75;
  float downChance = 0.25;
  float leftChance = 0.35;
  float rightChance = 0.15;

  int speed = 5;
  Bacteria(int tempX, int tempY) {
    x = tempX;
    y = tempY;
  }

  void move() {
    rand = Math.random();
    
    if (rand < upChance) {
      y -= speed;
    } else if (rand < (upChance+downChance)) {
      y += speed;
    } 
    println(rand);
    println(y);
    // else if (rand < upChance+downChance+leftChance) {
    //   x -= speed;
    // } else if (rand < upChance+downChance+leftChance+rightChance) {
    //   x += speed;
    // }
  }

  void show() {
  	ellipse(x,y,30,30);
  }
}  
