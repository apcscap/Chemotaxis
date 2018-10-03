class Ball {
  int ballSize = 0;
  int spd = 0;
  int ballX = 0;
  int ballY = 0;
  int health = 100;
  private double xSpeed;
  private double ySpeed;
  Ball(int ballX, int ballY, int ballSize, int spd, int pointX, int pointY) {
    this.ballX = ballX;
    this.ballY = ballY;
    this.ballSize = ballSize;
    this.spd = spd;
    double xSpd = (pointX - this.ballX);
    double ySpd = (pointY - this.ballY);
    double factor = this.spd / Math.sqrt(xSpd * xSpd + ySpd * ySpd);
    xSpd *= factor;
    ySpd *= factor;
    this.xSpeed = xSpd;
    this.ySpeed = ySpd;
  }
  void move() {
    // check if it collides with wall
    if(ballX + xSpeed > 500) {
      ballX = 500;
      xSpeed *= -1;
    } else if(ballX + xSpeed < 0){
      ballX = 0;
      xSpeed *= -1;
    }
    // change positioning
    ballX += xSpeed;
    ballY += ySpeed;
    ellipse(ballX, ballY, ballSize, ballSize);
  }
  void loseHealth() {
    health -= 1;
  }
}
class Shooter {
  ArrayList<Ball> ballList = new ArrayList<Ball>();
  Shooter() {
    // NOTHING SO FAR IS INITIALIZED
  }
  void shoot(int x, int y) {
    Ball ball = new Ball(250, 500, 25, 5, x, y);
    ballList.add(ball);
  }
  void drawBalls() {
    for(int i=0;i<ballList.size();i++) {
      if(ballList.get(i).ballY < 0 || ballList.get(i).health <= 0) {
        ballList.remove(i);
        println("ballList: "+ballList);
        continue;
      }
      ballList.get(i).move();
    }
  }
}

Shooter shooter = new Shooter();

class Bacteria {
  int x, y, bodySize, initialX, initialY;
  Bacteria() {
    x = (int)(Math.random()*500);
    y = (int)(Math.random()*350);
    initialX = x;
    initialY = y;
    bodySize = (int)(Math.random()*10)+5;
  }
  int d(int a, int b) {
    return abs(a - b);
  }
  void move() {
    // for(int i=0;i<shooter.ballList.size();i++) {
      // int ballX = shooter.ballList.get(i).ballX;
      // int ballY = shooter.ballList.get(i).ballY;
      // float distance = dist(x, y, ballX, ballY);
      // if(distance < shooter.ballList.get(i).ballSize - bodySize) {
      //   print("we gonners");
      // }
      // if(distance < 30) { // remove distance
      // println("distance: "+distance);
      // while(true) {
    if(shooter.ballList.size() >= 1) {
      int ballX = shooter.ballList.get(0).ballX;
      int ballY = shooter.ballList.get(0).ballY;
      if(ballX >= x) {
        x = x + (int)(Math.random()*5*(d(x, ballX)/50))+1;
      } else {
        x = x - (int)(Math.random()*5*(d(x, ballX)/50))-1;
      }
      if(shooter.ballList.get(0).ballY >= y) {
        y = y + (int)(Math.random()*5*(d(y, ballY)/50))+1;
      } else {
        y = y - (int)(Math.random()*5*(d(y, ballY)/50))-1;
      }
      if(dist(x, y, ballX, ballY) < shooter.ballList.get(0).ballSize) {
        shooter.ballList.get(0).loseHealth();
      }
    } else {
      if(initialX >= x) {
      x = x + (int)(Math.random()*3)+1;
      } else {
        x = x - (int)(Math.random()*3)-1;
      }
      if(initialY >= y) {
        y = y + (int)(Math.random()*3)+1;
      } else {
        y = y - (int)(Math.random()*3)-1;
      }
    }
    
      // }
      // }
    // }
  }
  void show() {
    ellipse(x, y, bodySize, bodySize);
  }
}
Bacteria[] colony;

void setup() {
  size(500,500);
  colony = new Bacteria[100];
  for(int i=0;i<colony.length;i++) {
    colony[i] = new Bacteria();
  }
}
void draw() {
  background(0);
  fill(255);
  for(int i=0;i<colony.length;i++) {
    colony[i].move();
    colony[i].show();
  }
  shooter.drawBalls();
}
void mouseMoved() {
  int yMouse = mouseY;
  if(mouseY < 400) {
    yMouse = 400;
  }
  fill(255,0,0);
  ellipse(mouseX, mouseY, 10, 10);
}
void mousePressed() {
  if (shooter.ballList.size()>=1) return;
  int yMouse = mouseY;
  if(mouseY < 400) {
    yMouse = 400;
  }
  shooter.shoot(mouseX, mouseY);
}