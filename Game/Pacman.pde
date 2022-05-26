
public class Pacman implements Character {
  boolean abilityOn;
  int[] directions;
  int x;
  int y;
  int speed;
  final int radius = 18;
  public Pacman(int xcor, int ycor, int s) {
    int[] d = new int[2];
    abilityOn = false;
    directions = d;
    x = xcor;
    y = ycor;
    speed = s;
  }

  void moveX() {
     x = x + speed * directions[0];
  }
  
  void moveY() {
     y = y + speed * directions[1];
  }

  int getX() {
    return x;
  }

  int getY() {
    return y;
  }

  void setX(int newX) {
    x = newX;
  }

  void setY(int newY) {
    y = newY;
  }

  int getSpeed() {
    return speed;
  }
  
  void setDirXLeft(){
    directions[0] = -1;
  }
  
  void setDirXRight(){
    directions[0] = 1;
  }
  
  void setDirYUp(){
    directions[1] = -1;
  }
  
  void setDirYDown(){
    directions[1] = 1;
  }

  void setSpeed(int newSpeed) {
    speed = newSpeed;
  }
  void display(int x, int y){
    arc(x, y, radius, radius, 7*SIXTH_PI, 17*SIXTH_PI, PIE);
  }
}
