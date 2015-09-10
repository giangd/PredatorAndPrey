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

Bacteria bob;

public void setup() {
	size(400,400);
  bob = new Bacteria(width/2,height/2);
}   

public void draw() {
	background(0,0,0);
	// bob.move();
	bob.show();
	

}  

class Bacteria {
  int x, y;
  double rand;
  // float upChance = downChance = leftChance = rightChance = 0.25;
  float upChance = 0.75f;
  float downChance = 0.25f;
  float leftChance = 0.35f;
  float rightChance = 0.15f;
  int timesUp = 0;
  int timesDown = 0;

  float speed = 0.1f;
  Bacteria(int tempX, int tempY) {
    x = tempX;
    y = tempY;
  }

  public void move() {
    rand = Math.random();
    
    if (rand < upChance) {
      y -= speed;
      timesUp++;
    } else if (rand < (upChance+downChance)) {
      y += speed;
      timesDown++;
    }
    println("down: " + timesDown);
    println("up: " + timesUp);
    // println(rand);
    // println(y);
    // else if (rand < upChance+downChance+leftChance) {
    //   x -= speed;
    // } else if (rand < upChance+downChance+leftChance+rightChance) {
    //   x += speed;
    // }
  }

  public void show() {
  	ellipse(x,y,30,30);
  }
}  
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Chemotaxis" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
