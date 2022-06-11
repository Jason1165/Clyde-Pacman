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
    mode = SCATTER;
    x = xcor;
    y = ycor;
    speed = s;
    colour = c;
    oldDir = new int[2];
    newDir = new int[2];
    chooseDir();
  }

  void canBeEaten(boolean eat) {
    eatable = eat;
  }

  void move() {
    x += newDir[0];
    y += newDir[1];
    oldDir[0] = newDir[0];
    oldDir[1] = newDir[1];
  }

  void chooseDir() {
    ArrayList<int[]> choices = new ArrayList<int[]>();
    for (int i = 0; i < directional.size(); i++) {
      int[] temp = directional.get(i);
      if (map.isValid(temp[0]+x, temp[1]+y, false) && !oppositeDir(temp[0], temp[1])) {
        choices.add(directional.get(i));
        if (!inCage() && map.get(temp[0]+x, temp[1]+y) == 'G') choices.remove(choices.size()-1);
      }
    }
    if (mode == CHASE) {
      int best = 0; 
      int len = map.BFS(x + choices.get(0)[0], y + choices.get(0)[1], p.getX(), p.getY());
      for (int i = 1; i < choices.size(); i++) {
        if (len > map.BFS(x + choices.get(i)[0], y + choices.get(i)[1], p.getX(), p.getY())) {
          len = map.BFS(x + choices.get(i)[0], y + choices.get(i)[1], p.getX(), p.getY());
          best = i;
        }
      }
      newDir[0] = choices.get(best)[0];
      newDir[1] = choices.get(best)[1];
    } else {
      int choice = (int)(Math.random()*choices.size());
      newDir[0] = choices.get(choice)[0];
      newDir[1] = choices.get(choice)[1];
    }
  }

  int dirX() {
    return newDir[0];
  }

  int dirY() {
    return newDir[1];
  }

  boolean inCage() {
    return (x >= 13 && x <= 17) && (y >= 10 && y <= 17);
  }

  boolean inCage(int xCor, int yCor) {
    return (xCor >= 13 && xCor <= 17) && (yCor >= 10 && yCor <= 17);
  }

  void display(float xCor, float yCor) {
    fill(colour);
    if (mode == FRIGHT) {
      fill(0, 0, 255);
    }
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

  void setMode(int newMode) {
    mode = newMode;
  }

  int getMode() {
    return mode;
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
