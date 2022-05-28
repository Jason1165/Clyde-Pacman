

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
  color colour;
  int[] oldDir;

  Ghost(int xcor, int ycor, float s, color c) {
    eatable = false;
    mode = 0;
    x = xcor;
    y = ycor;
    speed = s;
    colour = c;
    oldDir = new int[2];
  }

  void move() {
    int x_ = (int)random(0, 3) - 1;
    int y_ = (int)random(0, 3) - 1;
    while (!map.isValid((int)(x+x_), (int)(y+y_)) || (x_ == y_) ||(x_*-1 == y_) || oppositeDir((int)x_, (int)y_)){
      x_ = (int)random(0, 3) - 1;
      y_ = (int)random(0, 3) - 1;
    }
    oldDir[0] = x_;
    oldDir[1] = y_;
    x += x_;
    y += y_;
  }
  
  void display(float xCor, float yCor) {
    fill(colour);
    rect(xCor, yCor, 20, 20);
  }
  
  void moveX(){
    
  }
  
  void moveY(){
    
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
  
  boolean oppositeDir(int x_, int y_) {
    if (oldDir[0] == 0 && y_ == oldDir[1]) return false;
    if (oldDir[1] == 0 && x_ == oldDir[0]) return false;
    if (oldDir[0] != x_ && oldDir[1] != y_) return false;
    return true;
  }
}
