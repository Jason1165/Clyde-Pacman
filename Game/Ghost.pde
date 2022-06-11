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
    String dir = "";
    String num = "";
    if (dirX() == 0 && dirY() == 1) dir = "r";
    if (dirX() == 0 && dirY() == -1) dir = "l";
    if (dirX() == -1 && dirY() == 0) dir = "u";
    if (dirX() == 1 && dirY() == 0) dir = "d";
    if (count % 10 >= 4) num = "1";
    if (count % 10 <= 5) num = "2";
    if (mode == FRIGHT) dir = "f";
    String file = "g"+dir+num+".png";
    PImage image = loadImage(file);
    if (p.timer()!= 0 &&  p.timer() < 200 && p.timer() % 20 >= 10 && mode == FRIGHT) {
      for (int i = 0; i < image.width; i++) {
        for (int j = 0; j < image.width; j++) {
          if (image.get(i, j) == color(0, 0, 255)) {
            image.set(i, j, color(255, 255, 255));
          }
          if (image.get(i, j) == color(255, 255, 0)) {
            image.set(i, j, color(255, 0, 0));
          }
          if (image.get(i, j) == color(255, 255, 153)) {
            image.set(i, j, color(204, 0, 0));
          }
        }
      }
      image(image, xCor, yCor);
    } else if (mode == FRIGHT) {
      image(image, xCor, yCor);
    } else {
      for (int i = 0; i < image.width; i++) {
        for (int j = 0; j < image.width; j++) {
          if (image.get(i, j) == color(0, 0, 0)) {
            image.set(i, j, colour);
          }
        }
      }
      image(image, xCor, yCor);
    }
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
