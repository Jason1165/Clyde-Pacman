Maze map;
Pacman p;
final static int down = 3;
final float EIGHT_PI = QUARTER_PI/2;
final float SIXTH_PI = HALF_PI/3;
void setup() {
  size(560, 720);
  map = new Maze("highScore.txt", "pacman.txt");
  p = new Pacman(100,90,10.0,1,1);
}
void draw() {
  map.displayMaze();
  p.display(p.getX(), p.getY());
}
void keyPressed() {
  if(keyPressed){
    if(key == 'w'){
      p.setY(p.getY()-1);
    }else if(key =='a'){
      p.setX(p.getX()-1);
    }else if(key =='s'){
      p.setY(p.getY()+1);
    }else if(key =='d'){
      p.setX(p.getX()+1);
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
