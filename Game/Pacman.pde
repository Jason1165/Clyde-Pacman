
public class Pacman implements Character {
  boolean abilityOn;
  int[] directions;
  float x;
  float y;
  float speed;
  final int radius = 9;
  public Pacman(int xcor, int ycor, float s) {
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

  float getX() {
    return x;
  }

  float getY() {
    return y;
  }

  void setX(float newX) {
    x = newX;
  }

  void setY(float newY) {
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
  void display(float x, float y){
    fill(255, 255, 0);
    arc(x, y, radius * 2, radius * 2, 7*SIXTH_PI, 17*SIXTH_PI, PIE);
  }
  int getRadius(){
   return radius; 
  }
}
