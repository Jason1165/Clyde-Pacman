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
  
  int getX(){
    return x;
  }
  
  int getY(){
    return y;
  }
  
  void setX(int newX){
    x = newX;
  }
  
  void setY(int newY){
    y = newY;
  }
  
  float getSpeed(){
    return speed;
  }
  
  void setSpeed(float newSpeed){
   speed = newSpeed; 
  }
  /*
  void display(int x, int y);
  */
}
