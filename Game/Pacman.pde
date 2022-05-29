
public class Pacman implements Character {
  boolean abilityOn;
  int[] directions;
  int x;
  int y;
  float speed;
  final int radius = 9;
  int dir;
  
  public Pacman(int xcor, int ycor, float s) {
    int[] d = new int[2];
    abilityOn = false;
    directions = d;
    x = xcor;
    y = ycor;
    speed = s;
    dir = 3;
  }
  
  int getDir() {
    return dir;
  }
  
  void setDir(int newDir) {
    dir = newDir;
  }

  void moveX() {
     x = x + directions[0];
  }
  
  void moveY() {
     y = y + directions[1];
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

  float getSpeed() {
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

  void setSpeed(float newSpeed) {
    speed = newSpeed;
  }
  
  void display(float xCor, float yCor){
    fill(255, 255, 0);
    arc(xCor+10, yCor+10, radius * 2, radius * 2, (dir*3-2)*SIXTH_PI, (dir*3+8)*SIXTH_PI, PIE);
  }
  
  int getRadius(){
   return radius; 
  }
}
