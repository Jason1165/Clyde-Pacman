Maze map;
final static int down = 3; // how much space to leave at top
// each 'pixel' is 20 by 20
final float SIXTH_PI = HALF_PI/3; // const for pacman arc;
ArrayList<Ghost> ghosts = new ArrayList<Ghost>();

void setup() {
  size(560, 720);
  map = new Maze("highScore.txt", "pacman.txt");
  ghosts.add(new Ghost(11, 14, 60, color(255, 0, 0)));
  //ghosts.add(new Ghost(11, 15, 50, color(0, 255, 0)));
  //ghosts.add(new Ghost(11, 16, 40, color(0, 0, 255)));
  //ghosts.add(new Ghost(11, 17, 30, color(0, 155, 0)));
  
}  
void draw() {
  map.displayMaze();
  for (int i = 0; i < ghosts.size(); i++) {
    Ghost g = ghosts.get(i);
    g.display(g.getY()*20, (g.getX()+down)*20);
    //if (frameCount % g.getSpeed() == 0) {
    //  ghosts.get(i).move();
    //}
  }
}
void keyPressed() {
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
