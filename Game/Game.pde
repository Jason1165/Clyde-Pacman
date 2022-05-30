Maze map;
Pacman p;
final static int down = 3; // how much space to leave at top
// each 'pixel' is 20 by 20
final float SIXTH_PI = HALF_PI/3; // const for pacman arc;
ArrayList<Ghost> ghosts = new ArrayList<Ghost>();

void setup() {
  size(560, 720);
  map = new Maze("highScore.txt", "pacman.txt");
  p = new Pacman(23, 13, 20);
  // so it looks a smaller speed is actually faster due to frames 
  ghosts.add(new Ghost(15, 14, 20, color(255, 0, 0))); // red
  ghosts.add(new Ghost(15, 15, 15, color(255, 184, 255))); // brilliant lavender
  ghosts.add(new Ghost(15, 16, 20, color(0, 255, 255))); // aqua
  ghosts.add(new Ghost(15, 17, 20, color(255, 184, 82))); // pastel orange
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
    } else {
      g.display(g.getY()*20 + g.dirY()*(20/g.getSpeed()) * (frameCount%g.getSpeed()), (g.getX()+down)*20 + g.dirX()*(20/g.getSpeed()) * (frameCount%g.getSpeed()));
    }
  }

  if (frameCount % p.getSpeed() == 0) {

    if (map.isValid(p.getX() + p.dirX(), p.getY() + p.dirY())) {
      p.move();
    }
    
    p.display(p.getY()*20, (p.getX()+down)*20);

    if (p.getTryDir() == 1) {
      if (map.isValid(p.getX(), p.getY()+1)) {
        p.setDir(p.getTryDir());
        p.setTryDir(0);
      }
    } else if (p.getTryDir() == 2) {
      if (map.isValid(p.getX()+1, p.getY())) {
        p.setDir(p.getTryDir());
        p.setTryDir(0);
      }
    } else if (p.getTryDir() == 3) {
      if (map.isValid(p.getX(), p.getY()-1)) {
        p.setDir(p.getTryDir());
        p.setTryDir(0);
      }
    } else if (p.getTryDir() == 4) {
      if (map.isValid(p.getX()-1, p.getY())) {
        p.setDir(p.getTryDir());
        p.setTryDir(0);
      }
    }

    if (p.getDir() == 3) {
      if (map.isValid(p.getX(), p.getY()-1)) {
        p.setDir(0, -1);
      }
    } else if (p.getDir() == 4) {
      if (map.isValid(p.getX()-1, p.getY())) {
        p.setDir(-1, 0);
      }
    } else if (p.getDir() == 1) {
      if (map.isValid(p.getX(), p.getY()+1)) {
        p.setDir(0, 1);
      }
    } else if (p.getDir() == 2) {
      if (map.isValid(p.getX()+1, p.getY())) {
        p.setDir(1, 0);
      }
    }
  } 

  // MOVEMENT IS NOT PERFECT, FLICKERING
  else {
    if (map.isValid(p.getX()+p.dirX(), p.getY()+p.dirY())) {
      p.display(p.getY()*20 + p.dirY()*(frameCount%p.getSpeed())*(20/p.getSpeed()), (p.getX()+down)*20 + p.dirX()*(frameCount%p.getSpeed())*(20/p.getSpeed()));
    } else {
      p.display(p.getY()*20, (p.getX()+down)*20);
    }
  }

  // ACTUAL GAME LOGIC
  if (map.get(p.getX(), p.getY()) == 'D') {
    map.set(p.getX(), p.getY(), 'd');
    map.addScore(10);
  }
  if (map.get(p.getX(), p.getY()) == 'P') {
    map.set(p.getX(), p.getY(), 'p');
    map.addScore(50);
  }
}

void keyPressed() {
  if (keyPressed) {
    if (key == 'w') {
      p.setTryDir(4);
    } else if (key =='a') {
      p.setTryDir(3);
    } else if (key =='s') {
      p.setTryDir(2);
    } else if (key =='d') {
      p.setTryDir(1);
    }
  }
}

public static char[] toCharArray(String str) {
  char[] c = new char[str.length()];
  for (int i = 0; i < str.length(); i++) {
    c[i] = str.charAt(i);
  }
  return c;
}
