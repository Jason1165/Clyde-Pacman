

//public class Ghost implements Character {
//  boolean eatable;
//  int mode;
//}
public class Ghost implements Character {
  boolean eatable;
  int mode;
  float x; 
  float y;
  float speed;

  Ghost(float xcor, float ycor, float s) {
    eatable = false;
    mode = 0;
    x = xcor;
    y = ycor;
    speed = s;
  }

  void move() {
    int x_ = (int)random(0, 3) - 1;
    int y_ = (int)random(0, 3) - 1;
    while (!map.isValid((int)(x+x_), (int)(y+y_)) || ((int)x_ == (int)y_) ||((int)x_*-1 == (int)y_)){
      x_ = (int)random(0, 3) - 1;
      y_ = (int)random(0, 3) - 1;
      //println(x_ + " " + y_);
    }
    x += x_;
    y += y_;
  }
  
  void moveX(){
    
  }
  
  void moveY(){
    
  }

  void display() {
    fill(0, 255, 0);
    rect(y*20, (x+3)*20, 20, 20);
  }

  void display(float x, float y) {
  }

  void setX(float newX) {
    x = newX;
  }

  void setY(float newY) {
    y = newY;
  }

  float getX() {
    return x;
  }

  float getY() {
    return y;
  }
  
  void setSpeed(float newSpeed) {
    speed = newSpeed;
  }

  float getSpeed() {
    return speed;
  }
}
