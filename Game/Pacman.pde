public class Pacman implements Character {
  boolean abilityOn;
  int xDirection;
  int yDirection;
  int x;
  int y;
  float speed;
  public Pacman(int xcor, int ycor, float s, int xDir, int yDir){
   abilityOn = false;
   xDirection = xDir;
   yDirection = yDir;
   x = xcor;
   y = ycor;
   speed = s;
  }
  
  void move(){//need to account for boundaries later
    x += speed * xDirection;
    y += speed * yDirection;
  }
  /*
  void display(int x, int y);
  int getX();
  int getY();
  void setX(int newX);
  void setY(int newY);
  float getSpeed();
  void setSpeed(float newSpeed);
  */
}
