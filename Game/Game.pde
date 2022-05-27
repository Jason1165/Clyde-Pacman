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
  ghosts.add(new Ghost(11, 14, 60, color(255, 0, 0)));
  ghosts.add(new Ghost(11, 15, 50, color(0, 255, 0)));
  ghosts.add(new Ghost(11, 16, 40, color(0, 0, 255)));
  ghosts.add(new Ghost(11, 17, 30, color(0, 155, 0)));
}  

void draw() {
  map.displayMaze();
  for (int i = 0; i < ghosts.size(); i++) {
    Ghost g = ghosts.get(i);
    g.display(g.getY()*20, (g.getX()+down)*20);
    if (frameCount % g.getSpeed() == 0) {
      ghosts.get(i).move();
    }
  }
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
}
//branch message

public static char[] toCharArray(String str) {
  char[] c = new char[str.length()];
  for (int i = 0; i < str.length(); i++) {
    c[i] = str.charAt(i);
  }
  return c;
}
