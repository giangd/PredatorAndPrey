
void setup() {
}   

void draw() {
}  

class Bacteria {
  int x, y;
  float rand,upChance,downChance,leftChance,rightChance;

  Bacteria(int tempX, int tempY) {
    x = tempX;
    y = tempY;
  }

  void move() {
    rand = random();
    if (rand < upChance) {
      
    } else if (rand < upChance+downChance) {
      
    } else if (rand < upChance+downChance+leftChance) {
      
    } else if (rand < upChance+downChance+leftChance+rightChance) {
      
    }
  }

  void show() {
  }
}    
