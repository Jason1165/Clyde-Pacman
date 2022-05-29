public class Ghost implements Character {
  boolean eatable;
  int mode;
  int x; 
  int y;
  float speed;
  color colour;
  int[] oldDir;
  int[] newDir;

  Ghost(int xcor, int ycor, float s, color c) {
    eatable = false;
    mode = 0;
    x = xcor;
    y = ycor;
    speed = s;
    colour = c;
    oldDir = new int[2];
    newDir = new int[2];
    chooseDir();
  }

  void move() {
    x += newDir[0];
    y += newDir[1];
    oldDir[0] = newDir[0];
    oldDir[1] = newDir[1];
  }

  void chooseDir() {
    int x_ = (int)random(0, 3) - 1;
    int y_ = (int)random(0, 3) - 1;
    while (!map.isValid((int)(x+x_), (int)(y+y_)) || (x_ == y_) ||(x_*-1 == y_) || oppositeDir((int)x_, (int)y_)) {
      x_ = (int)random(0, 3) - 1;
      y_ = (int)random(0, 3) - 1;
    }
    newDir[0] = x_;
    newDir[1] = y_;
  }

  int dirX() {
    return newDir[0];
  }

  int dirY() {
    return newDir[1];
  }

  //void display(float xCor, float yCor) {
  //  fill(colour);
  //  rect(xCor, yCor, 20, 20);
  //}

  void display(float xCor, float yCor) {
    fill(colour);
    rect(xCor+8, yCor+3, 3, 1);
    rect(xCor+6, yCor+4, 7, 1);
    rect(xCor+5, yCor+5, 9, 1);
    rect(xCor+4, yCor+6, 3, 1);
    rect(xCor+9, yCor+6, 3, 1);
    rect(xCor+14, yCor+6, 1, 1);
    rect(xCor+3, yCor+9, 1, 8);
    rect(xCor+4, yCor+7, 1, 9);
    rect(xCor+5, yCor+7, 1, 8);
    rect(xCor+6, yCor+10, 1, 6);
    rect(xCor+7, yCor+11, 1, 6);
    rect(xCor+8, yCor+11, 1, 4);
    rect(xCor+9, yCor+10, 1, 5);
    rect(xCor+10, yCor+7, 1, 10);
    rect(xCor+11, yCor+10, 1, 7);
    rect(xCor+12, yCor+11, 1, 5);
    rect(xCor+13, yCor+11, 1, 4);
    rect(xCor+14, yCor+10, 1, 6);
    rect(xCor+15, yCor+9, 1, 8);
    fill(255);
    rect(xCor+7, yCor+6, 2, 1);
    rect(xCor+6, yCor+7, 2, 2);
    rect(xCor+6, yCor+9, 4, 1);
    rect(xCor+7, yCor+10, 2, 1);
    rect(xCor+12, yCor+6, 2, 1);
    rect(xCor+11, yCor+7, 2, 2);
    rect(xCor+11, yCor+9, 4, 1);
    rect(xCor+12, yCor+10, 2, 1);
    fill(0, 0, 255);
    rect(xCor+8, yCor+7, 2, 2);
    rect(xCor+13, yCor+7, 2, 2);
  }

  void moveX() {
  }

  void moveY() {
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

  boolean oppositeDir(int x_, int y_) {
    if (oldDir[0] == 0 && y_ == oldDir[1]) return false;
    if (oldDir[1] == 0 && x_ == oldDir[0]) return false;
    if (oldDir[0] != x_ && oldDir[1] != y_) return false;
    return true;
  }
}
