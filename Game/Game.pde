Maze map;
Pacman p;
final static int down = 3;
final float EIGHT_PI = QUARTER_PI/2;
final float SIXTH_PI = HALF_PI/3;
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
//branch message


public static char[] toCharArray(String str) {
  char[] c = new char[str.length()];
  for (int i = 0; i < str.length(); i++) {
    c[i] = str.charAt(i);
  }
  return c;
}
