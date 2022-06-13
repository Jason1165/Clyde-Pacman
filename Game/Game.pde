Maze map;
Pacman p;
final static int down = 3; // how much space to leave at top
final float SIXTH_PI = HALF_PI/3; // const for pacman arc;
int ghostsKilled;
int dotsEaten;
boolean fruitSpawned;
ArrayList<int[]> directional;
ArrayList<Ghost> ghosts;
int count;
boolean pause;
ArrayList<Ghost> ghostsTemp;
boolean display6, display7, display8, display9, toggle6, toggle7, toggle8, toggle9;

// modes
final static int CHASE = 1;
final static int SCATTER = 0;
final static int FRIGHT = 2;
final static int CAGE = 3;

void setup() {
  ghosts = new ArrayList<Ghost>();
  directional = new ArrayList<int[]>();
  pause = false;
  count= 0;
  directional.add(new int[] {1, 0});
  directional.add(new int[] {-1, 0});
  directional.add(new int[] {0, 1});
  directional.add(new int[] {0, -1});

  size(560, 720);
  map = new Maze("highScore.txt", "pacman.txt");
  p = new Pacman(23, 13, 8);
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
  display6 = true;
  display7 = true;
  display8 = true;
  display9 = true;
  toggle6 = false;
  toggle7 = false;
  toggle8 = false;
  toggle9 = false;
} 


void draw() {
  map.displayMaze();
  if (toggle6) {
    if (ghosts.get(0).getMode() == CHASE) {
      fill(255, 0, 0);
      rect(p.getY()*20, p.getX()*20 + 20 * 3, 20, 20);
    }
    else if (ghosts.get(0).getMode() == SCATTER) {
      fill(255, 0, 0);
      rect(26*20, 20 + 20 * 3, 20, 20);
    }
  }
  if (toggle7) {
    if (ghosts.get(0).getMode() == CHASE) {
      fill(255, 184, 82);
      rect(p.getY()*20, p.getX()*20 + 20 * 3, 20, 20);
    }
    else if (ghosts.get(0).getMode() == SCATTER) {
      fill(255, 184, 82);
      rect(20, 29 * 20 + 20 * 3, 20, 20);
    }
  }
  if (toggle8) {
    if (ghosts.get(0).getMode() == CHASE) {
      fill(255, 184, 255);
      rect((p.getY() + 2 * p.dirY()) * 20, (p.getX() + 2 * p.dirX()) * 20 + 20 * 3, 20, 20);
    }
    else if (ghosts.get(0).getMode() == SCATTER) {
      fill(255, 184, 255);
      rect(20, 20 + 20 * 3, 20, 20);
    }
  }
  if (toggle9) {
    if (ghosts.get(1).getMode() == CHASE) {
      fill(0, 255, 255);
      int XblinkyDis = p.getX() - ghosts.get(0).x;
      int YblinkyDis = p.getY() - ghosts.get(0).y;
      rect((p.getY() + 2 * YblinkyDis) * 20, (p.getX() + 2 * XblinkyDis) * 20 + 20 * 3, 20, 20);
    }
    else if (ghosts.get(1).getMode() == SCATTER) {
      fill(0, 255, 255);
      rect(26 * 20, 29 * 20 + 20 * 3, 20, 20);
    }
  }

  if (!pause) {
    count ++;
  } 

  if (map.over()) {
    map.gameOverDisplay();
  } else if (count <= 120) {
    map.ready();
  } else {
    for (int i = 0; i < ghosts.size(); i++) {
      Ghost g = ghosts.get(i);
      if (count % g.getSpeed() < 1 && !map.over() && !pause) {
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

    if (count % p.getSpeed() < 1 && !map.over() && !pause) {
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
      map.addScore(100 * (map.getLevel()*2 - 1));
      fruitSpawned = false;
    }

    if (map.get(p.getX(), p.getY()) == 'P') {
      map.set(p.getX(), p.getY(), 'p');
      map.addScore(50);
      p.setTimer((int)(p.getSpeed()*p.getSpeed()*10 / (1 + map.getLevel()/5.0) + p.timer()));
      p.abilityChange(true);
      for (int i = 0; i < ghosts.size(); i++) {
        ghosts.get(i).setMode(FRIGHT);
      }
    }

    if (map.containsNoFood()) {
      map.refillFood();
      ghosts = ghostsTemp;
      toggle6 = false;
      toggle7 = false;
      toggle8 = false;
      toggle9 = false; 
      map.respawn();
      map.addLives(1);
      map.addLevel(1);
      // map level stuff
    }

    //ghosts.eaten();
    for (int i = 0; i < ghosts.size(); i++) {
      if (ghosts.get(i).getX() == p.getX() && ghosts.get(i).getY() == p.getY()) {
        if (!p.ability() || ghosts.get(i).getMode() != FRIGHT) {
          ghosts = ghostsTemp;
          toggle6 = false;
          toggle7 = false;
          toggle8 = false;
          toggle9 = false; 
          map.respawn();
        } else {
          ghostsKilled += 1;
          map.addScore((int)(200*(Math.pow(2, ghostsKilled - 1))));
          ghosts.get(i).setX(14);
          ghosts.get(i).setY(12);
          ghosts.get(i).setMode(CAGE);
        }
      }
    }

    if (map.containsNoFood()) {
      toggle6 = false;
      toggle7 = false;
      toggle8 = false;
      toggle9 = false; 
      ghosts = ghostsTemp;
      map.refillFood();
      map.respawn();
      map.addLives(1);
      map.addLevel(1);
      // map level stuff
    }

    //ghosts.eaten();
    for (int i = 0; i < ghosts.size(); i++) {
      if (abs(ghosts.get(i).getX() - p.getX()) < 1 && abs(ghosts.get(i).getY() - p.getY()) < 1) {
        if (!p.ability() || ghosts.get(i).getMode() != FRIGHT) {
          ghosts = ghostsTemp;
          toggle6 = false;
          toggle7 = false;
          toggle8 = false;
          toggle9 = false;  
          map.respawn();
        } else {
          ghostsKilled += 1;
          map.addScore((int)(200*(Math.pow(2, ghostsKilled - 1))));
          ghosts.get(i).setX(14);
          ghosts.get(i).setY(12);
          ghosts.get(i).setMode(CAGE);
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
      setup();
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
    } else if (key == '6') {
      display6 = true;
      display7 = false;
      display8 = false;
      display9 = false;
      toggle6 = false;
      toggle7 = false;
      toggle8 = false;
      toggle9 = false;
      ghosts = ghostsTemp;
      Ghost g = ghostsTemp.get(0);
      ArrayList<Ghost> ghostsNew = new ArrayList<Ghost>();
      ghostsNew.add(g);
      ghosts = ghostsNew;
    } else if (key == '7') {
      display6 = false;
      display7 = true;
      display8 = false;
      display9 = false;
      toggle6 = false;
      toggle7 = false;
      toggle8 = false;
      toggle9 = false;
      ghosts = ghostsTemp;
      Ghost g = ghostsTemp.get(1);
      ArrayList<Ghost> ghostsNew = new ArrayList<Ghost>();
      ghostsNew.add(g);
      ghosts = ghostsNew;
    } else if (key == '8') {
      display6 = false;
      display7 = false;
      display8 = true;
      display9 = false;
      toggle6 = false;
      toggle7 = false;
      toggle8 = false;
      toggle9 = false;
      ghosts = ghostsTemp;
      Ghost g = ghostsTemp.get(2);
      ArrayList<Ghost> ghostsNew = new ArrayList<Ghost>();
      ghostsNew.add(g);
      ghosts = ghostsNew;
    } else if (key == '9') {
      display6 = false;
      display7 = false;
      display8 = false;
      display9 = true;
      toggle6 = false;
      toggle7 = false;
      toggle8 = false;
      toggle9 = false;
      ghosts = ghostsTemp;
      Ghost g = ghostsTemp.get(3);
      Ghost g1 = ghostsTemp.get(0);
      ArrayList<Ghost> ghostsNew = new ArrayList<Ghost>();
      ghostsNew.add(g1);
      ghostsNew.add(g);
      ghosts = ghostsNew;
    } else if (key == '0') {
      display6 = true;
      display7 = true;
      display8 = true;
      display9 = true;
      toggle6 = false;
      toggle7 = false;
      toggle8 = false;
      toggle9 = false;
      ghosts = ghostsTemp;
    } else if (key == ' ') {
      if (display6 && !display7 && !display8 && !display9) {
        toggle6 = true;
        toggle7 = false;
        toggle8 = false;
        toggle9 = false;
      }
      if (!display6 && display7 && !display8 && !display9) {
        toggle6 = false;
        toggle7 = true;
        toggle8 = false;
        toggle9 = false;
      }
      if (!display6 && !display7 && display8 && !display9) {
        toggle6 = false;
        toggle7 = false;
        toggle8 = true;
        toggle9 = false;
      }
      if (!display6 && !display7 && !display8 && display9) {
        toggle6 = false;
        toggle7 = false;
        toggle8 = false;
        toggle9 = true;
      }
    } else if (key == 'p') {
      pause = !pause;
    } else if (key == 'l') {
      p.setTimer((int)(420 + p.timer()));
      p.abilityChange(true);
      for (int i = 0; i < ghosts.size(); i++) {
        ghosts.get(i).setMode(FRIGHT);
      }
    } else if (key == 'c') {
      map.clearFood();
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
