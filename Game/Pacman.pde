
public class Pacman implements Character {
  boolean abilityOn;
  int abilityTimer;
  int[] directions;
  int x;
  int y;
  float speed;
  final int radius = 10;
  int dir;
  int[] newDir;
  int tryDir;

  public Pacman(int xcor, int ycor, float s) {
    int[] d = new int[2];
    abilityOn = false;
    directions = d;
    x = xcor;
    y = ycor;
    speed = s;
    dir = 3;
    newDir = new int[2];
    tryDir = 3;
  }

  void setTimer(int time) {
    abilityTimer = time;
  }

  int timer() {
    return abilityTimer;
  }

  void abilityChange(boolean abil) {
    abilityOn = abil;
  }

  boolean ability() {
    return abilityOn;
  }

  int getDir() {
    return dir;
  }

  int getTryDir() {
    return tryDir;
  }

  void setTryDir(int tryD) {
    tryDir = tryD;
  }

  void setDir(int newDir) {
    dir = newDir;
  }

  void move() {
    x += directions[0];
    y += directions[1];
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

  int dirY() {
    return directions[1];
  }

  int dirX() {
    return directions[0];
  }

  void setDir(int i, int j) {
    directions[0] = i;
    directions[1] = j;
  }

  void setSpeed(float newSpeed) {
    speed = newSpeed;
  }

  void display(float xCor, float yCor) {
    fill(255, 255, 0);
    //arc(xCor+10, yCor+10, radius * 2, radius * 2, (dir*3-2)*SIXTH_PI, (dir*3+8)*SIXTH_PI, PIE);
    int module = count % 11;
    if (module < 3) {
      arc(xCor+10, yCor+10, radius * 2, radius * 2, (dir*3-2)*SIXTH_PI, (dir*3+8)*SIXTH_PI, PIE);
    }
    else if (module < 6){
      arc(xCor+10, yCor+10, radius * 2, radius * 2, (dir*2-1)*QUARTER_PI, (dir*2+5)*QUARTER_PI, PIE);
    }
    else if (module < 9) {
      arc(xCor+10, yCor+10, radius * 2, radius * 2, (dir*3-2)*SIXTH_PI, (dir*3+8)*SIXTH_PI, PIE);
    }
    else {
      ellipse(xCor+10, yCor+10, radius * 2, radius * 2);
    }
  }

  int getRadius() {
    return radius;
  }
}
