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
  // so it looks a smaller speed is actually faster due to frames 
  ghosts.add(new Ghost(11, 14, 20, color(255, 0, 0))); // red
  ghosts.add(new Ghost(11, 15, 15, color(255, 184, 255))); // brilliant lavender
  ghosts.add(new Ghost(11, 16, 20, color(0, 255, 255))); // aqua
  ghosts.add(new Ghost(11, 17, 20, color(255, 184, 82))); // pastel orange
  frameRate(60);
} 

void draw() {
  map.displayMaze();
  for (int i = 0; i < ghosts.size(); i++) {
    Ghost g = ghosts.get(i);
    if (frameCount % g.getSpeed() == 0) {
      ghosts.get(i).move();
      ghosts.get(i).chooseDir();
      g.display(g.getY()*20, (g.getX()+down)*20);
    }
    else {
      g.display(g.getY()*20 + g.dirY()*(20/g.getSpeed()) * (frameCount%g.getSpeed()), (g.getX()+down)*20 + g.dirX()*(20/g.getSpeed()) * (frameCount%g.getSpeed()));
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
  if (key == ' ') delay(500);
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
