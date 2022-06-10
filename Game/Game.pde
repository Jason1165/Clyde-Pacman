Maze map;
Pacman p;
final static int down = 3; // how much space to leave at top
final float SIXTH_PI = HALF_PI/3; // const for pacman arc;
int ghostsKilled;
int dotsEaten;
boolean fruitSpawned;
ArrayList<int[]> directional = new ArrayList<int[]>();
ArrayList<Ghost> ghosts = new ArrayList<Ghost>();
ArrayList<Ghost> ghostsTemp = new ArrayList<Ghost>();

// modes
final static int CHASE = 1;
final static int SCATTER = 0;
final static int FRIGHT = 2;
final static int CAGE = 3;

void setup() {

  directional.add(new int[] {1, 0});
  directional.add(new int[] {-1, 0});
  directional.add(new int[] {0, 1});
  directional.add(new int[] {0, -1});

  size(560, 720);
  map = new Maze("highScore.txt", "pacman.txt");
  p = new Pacman(23, 13, 12);
  // so it looks a smaller speed is actually faster due to frames 
  ghosts.add(new Blinky()); // red
  ghosts.add(new Clyde()); // pastel orange
  ghosts.add(new Pinky()); // brilliant lavender
  ghosts.add(new Inky()); // aqua
  frameRate(60);
  ghostsKilled = 0;
  dotsEaten = 0;
  fruitSpawned = false;
  ghostsTemp = ghosts;
} 

void draw() {
  float count = frameCount; 
  map.displayMaze();

  if (map.over()) {
    map.gameOverDisplay();
  }

  //ghosts.tick();

  for (int i = 0; i < ghosts.size(); i++) {
    Ghost g = ghosts.get(i);
    if (count % g.getSpeed() < 1 && !map.over()) {
      if (g.getY() == 1 && g.dirY() == -1 && map.get(g.getX(), g.getY()-1) == 'S') {
        g.setY(28);
        g.move();
      } else if (g.getY() == 26 && g.dirY() == 1 && map.get(g.getX(), g.getY()+1) == 'S') {
        g.setY(0);
        g.move();
      } else {
        ghosts.get(i).move();
        ghosts.get(i).chooseDir();
        g.display(g.getY()*20, (g.getX()+down)*20);
      }
    } else if (map.over()) {
      g.display(g.getY()*20, (g.getX()+down)*20);
    } else {
      g.display(g.getY()*20 + g.dirY()*(20/g.getSpeed()) * (count%g.getSpeed()), (g.getX()+down)*20 + g.dirX()*(20/g.getSpeed()) * (count%g.getSpeed()));
    }
  }

  if (count % p.getSpeed() < 1 && !map.over()) {
    if (p.getY() == 1 && p.getDir() == 3 && map.get(p.getX(), p.getY()-1) == 'S') {
      p.setY(28);
      p.move();
    } else if (p.getY() == 26 && p.getDir() == 1 && map.get(p.getX(), p.getY()+1) == 'S') {
      p.setY(0);
      p.move();
    } else if (map.isValid(p.getX() + p.dirX(), p.getY() + p.dirY(), true)) {
      p.move();
    }

    p.display(p.getY()*20, (p.getX()+down)*20);

    if (p.getTryDir() == 1) {
      if (map.isValid(p.getX(), p.getY()+1, true)) {
        p.setDir(p.getTryDir());
        p.setTryDir(0);
      }
    } else if (p.getTryDir() == 2) {
      if (map.isValid(p.getX()+1, p.getY(), true)) {
        p.setDir(p.getTryDir());
        p.setTryDir(0);
      }
    } else if (p.getTryDir() == 3) {
      if (map.isValid(p.getX(), p.getY()-1, true)) {
        p.setDir(p.getTryDir());
        p.setTryDir(0);
      }
    } else if (p.getTryDir() == 4) {
      if (map.isValid(p.getX()-1, p.getY(), true)) {
        p.setDir(p.getTryDir());
        p.setTryDir(0);
      }
    }

    if (p.getDir() == 3) {
      if (map.isValid(p.getX(), p.getY()-1, true)) {
        p.setDir(0, -1);
      }
    } else if (p.getDir() == 4) {
      if (map.isValid(p.getX()-1, p.getY(), true)) {
        p.setDir(-1, 0);
      }
    } else if (p.getDir() == 1) {
      if (map.isValid(p.getX(), p.getY()+1, true)) {
        p.setDir(0, 1);
      }
    } else if (p.getDir() == 2) {
      if (map.isValid(p.getX()+1, p.getY(), true)) {
        p.setDir(1, 0);
      }
    }
  } else {
    if (map.isValid(p.getX()+p.dirX(), p.getY()+p.dirY(), true)) {
      p.display(p.getY()*20 + p.dirY()*(count%p.getSpeed())*(20/p.getSpeed()), (p.getX()+down)*20 + p.dirX()*(count%p.getSpeed())*(20/p.getSpeed()));
    } else {
      p.display(p.getY()*20, (p.getX()+down)*20);
    }
  }

  // ACTUAL GAME LOGIC
  if (map.get(p.getX(), p.getY()) == 'D') {
    map.set(p.getX(), p.getY(), 'd');
    map.addScore(10);
    if (fruitSpawned == false) {
      dotsEaten ++;
    }
  }

  if (map.get(p.getX(), p.getY()) == 'f') {
    map.set(p.getX(), p.getY(), 'S');
    map.addScore(100);
    fruitSpawned = false;
  }

  if (map.get(p.getX(), p.getY()) == 'P') {
    map.set(p.getX(), p.getY(), 'p');
    map.addScore(50);
    p.setTimer((int)(p.getSpeed()*p.getSpeed()*10 / (1 + map.getLevel()/10.0) + p.timer()));
    p.abilityChange(true);
    for (int i = 0; i < ghosts.size(); i++) {
      ghosts.get(i).setMode(FRIGHT);
    }
  }

  if (map.containsNoFood()) {
    map.refillFood();
    map.respawn();
    map.addLevel(1);
    // map level stuff
  }

  //ghosts.eaten();
  for (int i = 0; i < ghosts.size(); i++) {
    if (ghosts.get(i).getX() == p.getX() && ghosts.get(i).getY() == p.getY()) {
      if (!p.ability()) {
        map.respawn();
      } else {
        ghostsKilled += 1;
        map.addScore((int)(200*(Math.pow(2, ghostsKilled - 1))));
        ghosts.get(i).setX(14);
        ghosts.get(i).setY(12);
        ghosts.get(i).setMode(CHASE);
      }
    }
  }

  if (p.timer() > 0) {
    p.setTimer(p.timer()-1);
    // println(p.timer());
  }

  if (p.timer() == 1) {
    p.abilityChange(false);
    ghostsKilled = 0;
    for (int i = 0; i < ghosts.size(); i++) {
      ghosts.get(i).setMode(CHASE);
    }
  }

  if (map.getLives() == 0) {
    map.gameOver();
    map.storeHighScore("highScore.txt");
  }

  if (dotsEaten == 30) {
    fruitSpawned = true;
    dotsEaten = 0;
    map.set(17, 14, 'f');
  }
}

void keyPressed() {
  if (keyPressed) {
    if (key == 'w' || keyCode == UP) {
      p.setTryDir(4);
    } else if (key =='a' || keyCode == LEFT) {
      p.setTryDir(3);
    } else if (key =='s' || keyCode == DOWN) {
      p.setTryDir(2);
    } else if (key =='d' || keyCode == RIGHT) {
      p.setTryDir(1);
    } else if (key == 'r') {
      map.respawn();
      map = new Maze("highScore.txt", "pacman.txt");
    } else if (key == '1') {
      map.addLives(-1*(map.getLives()-1));
    } else if (key == '2') {
      p.setSpeed(p.getSpeed()*0.5);
    } else if (key == '3') {
      p.setSpeed(p.getSpeed()*1.5);
    } else if (key == 'x') {
      for (int i = 0; i < ghosts.size(); i++) {
        ghosts.get(i).setSpeed(5);
        ghosts.get(i).setMode(CHASE);
      }
    } else if (key == '4') {
      map.addLevel(1);
    } else if (key == '5') {
      map.addLevel(-1);
    }
    else if(key == '6'){
      ghosts = ghostsTemp;
      Ghost g = ghostsTemp.get(0);
      ArrayList<Ghost> ghostsNew = new ArrayList<Ghost>();
      ghostsNew.add(g);
      ghosts = ghostsNew;
    }
    else if(key == '7'){
      ghosts = ghostsTemp;
      Ghost g = ghostsTemp.get(1);
      ArrayList<Ghost> ghostsNew = new ArrayList<Ghost>();
      ghostsNew.add(g);
      ghosts = ghostsNew;
    }
    else if(key == '8'){
      ghosts = ghostsTemp;
      Ghost g = ghostsTemp.get(2);
      ArrayList<Ghost> ghostsNew = new ArrayList<Ghost>();
      ghostsNew.add(g);
      ghosts = ghostsNew;
    }
    else if(key == '9'){
      ghosts = ghostsTemp;
      Ghost g = ghostsTemp.get(3);
      ArrayList<Ghost> ghostsNew = new ArrayList<Ghost>();
      ghostsNew.add(g);
      ghosts = ghostsNew;
    }
    else if(key == '0'){
      ghosts = ghostsTemp;
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
