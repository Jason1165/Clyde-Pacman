public class Ghost implements Character {
  boolean eatable;
  int mode;
  int x; 
  int y;
  float speed;

  Ghost(int xcor, int ycor, float s) {
    eatable = false;
    mode = 0;
    x = xcor;
    y = ycor;
    speed = s;
  }

  void move() {
    int x_ = (int)random(0, 3) - 1;
    int y_ = (int)random(0, 3) - 1;
    while (!map.isValid(x+x_, y+y_) || (x_ == y_) ||(x_*-1 == y_)){
      x_ = (int)random(0, 3) - 1;
      y_ = (int)random(0, 3) - 1;
      //println(x_ + " " + y_);
    }
    x += x_;
    y += y_;
  }

  void display() {
    fill(0, 255, 0);
    rect(y*20, (x+3)*20, 20, 20);
  }

  void display(int x, int y) {
  }

  void setX(int newX) {
    x = newX;
  }

  void setY(int newY) {
    y = newY;
  }

  int getX() {
    return x;
  }

  int getY() {
    return y;
  }
  
  void setSpeed(float newSpeed) {
    speed = newSpeed;
  }

  float getSpeed() {
    return speed;
  }
}
