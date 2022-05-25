Maze map;
final static int down = 3; // how much space to leave at top
// each 'pixel' is 20 by 20
final float SIXTH_PI = HALF_PI/3; // const for pacman arc;

void setup() {
  size(560, 720);
  map = new Maze("highScore.txt", "pacman.txt");
}

void draw() {
  map.displayMaze();
}

void keyPressed() {
  map.storeHighScore("highScore.txt");
}


public static char[] toCharArray(String str) {
  char[] c = new char[str.length()];
  for (int i = 0; i < str.length(); i++) {
    c[i] = str.charAt(i);
  }
  return c;
}
