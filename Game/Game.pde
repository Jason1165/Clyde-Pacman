Maze map;
Pacman p;
final static int down = 3; // how much space to leave at top
// each 'pixel' is 20 by 20
final float SIXTH_PI = HALF_PI/3; // const for pacman arc;

void setup() {
  size(560, 720);
  map = new Maze("highScore.txt", "pacman.txt");
  p = new Pacman(width / 2,529,1);
}

void draw() {
  map.displayMaze();
  p.display(p.getX(), p.getY());
}

void keyPressed() {
  if(keyPressed){
    if(key == 'w'){
      p.setDirYUp();
      p.moveY();
    }else if(key =='a'){
      p.setDirXLeft();
      p.moveX();
    }else if(key =='s'){
      p.setDirYDown();
      p.moveY();
    }else if(key =='d'){
      p.setDirXRight();
      p.moveX();
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
