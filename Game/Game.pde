Maze map;
Pacman p;
final static int down = 3; // how much space to leave at top
// each 'pixel' is 20 by 20
final float SIXTH_PI = HALF_PI/3; // const for pacman arc;
boolean u;
boolean d;
boolean l;
boolean r;
ArrayList<Ghost> ghosts = new ArrayList<Ghost>();

void setup() {
  size(560, 720);
  map = new Maze("highScore.txt", "pacman.txt");
  p = new Pacman(width / 2, 529, 1);
  frameRate(60);
  ghosts.add(new Ghost(11, 13, 1));
}
void draw() {
  map.displayMaze();
  p.display(p.getX(), p.getY());
  if (u) {
    if (get((int)p.getX(), (int)p.getY() - p.getRadius() - 2 ) != color(51, 51, 255)) {
      p.setDirYUp();
      p.moveY();
    }
  } else if (d) {
    if (get((int)p.getX(), (int)p.getY() + p.getRadius() + 1) != color(51, 51, 255)) {
      p.setDirYDown();
      p.moveY();
    }
  } else if (l) {
    if (get((int)p.getX() - p.getRadius() - 1, (int)p.getY()) != color(51, 51, 255)) {
      p.setDirXLeft();
      p.moveX();
    }
  } else if (r) {
    if (get((int)p.getX() + p.getRadius() + 1, (int)p.getY()) != color(51, 51, 255)) {
      p.setDirXRight();
      p.moveX();
    }
  }
  ghosts.get(0).display();
}
void keyPressed() {
  if (keyPressed) {
    if (key == 'w') {
      u=true;
      d=false;
      l=false;
      r=false;
    } else if (key =='a') {
      u=false;
      d=false;
      l=true;
      r=false;
    } else if (key =='s') {
      u=false;
      d=true;
      l=false;
      r=false;
    } else if (key =='d') {
      u=false;
      d=false;
      l=false;
      r=true;
    }
  }
  ghosts.get(0).move();
}
//branch message


public static char[] toCharArray(String str) {
  char[] c = new char[str.length()];
  for (int i = 0; i < str.length(); i++) {
    c[i] = str.charAt(i);
  }
  return c;
}
