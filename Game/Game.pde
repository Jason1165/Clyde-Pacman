Maze map;
void setup() {
  size(560, 620);
  map = new Maze("highScore.txt", "pacman.txt");
}
void draw() {
  map.displayMaze();
}
void keyPressed() {
}
//branch message


public static char[] toCharArray(String str) {
  char[] c = new char[str.length()];
  for (int i = 0; i < str.length(); i++) {
    c[i] = str.charAt(i);
  }
  return c;
}
