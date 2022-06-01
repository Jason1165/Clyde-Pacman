import java.io.*;
import java.util.*;

public class Maze {
  char[][] maze;
  int score;
  int lives;
  int level;
  int highScore;

  boolean gameOver;
  boolean start;

  Maze(String score, String maze) {
    level = 1;
    lives = 3;
    highScore = getHighScore(score);
    generateMaze(maze);
    gameOver = false;
    start = true;
  }

  int getHighScore(String file) {
    try {
      BufferedReader r = createReader(file);
      String x = r.readLine();
      int bestScore = Integer.parseInt(x);
      return bestScore;
    }
    catch (IOException ex) {
      ex.printStackTrace();
      return 0;
    }
  }

  void changeStart() {
    start = !start;
  }

  void gameOver() {
    gameOver = true;
  }

  void generateMaze(String file) {
    try {
      BufferedReader r = createReader(file);
      String line;
      line = r.readLine();
      ArrayList<String> lines = new ArrayList<String>();
      while (line != null) {
        lines.add(line);
        line = r.readLine();
      }

      maze = new char[lines.size()][];
      for (int i = 0; i < lines.size(); i++) {
        maze[i] = toCharArray(lines.get(i));
      }
    }
    catch (IOException ex) {
      ex.printStackTrace();
    }
  }

  /*
  W = Wall
   S = Space or path
   D = Dot
   V = Void, darkness cannot be access
   P = Pellet with ability
   G = Gate
   d = old dot
   p = old pellet
   f = fruit
   */
  void displayMaze() {
    noStroke();
    background(0);
    for (int i = 0; i < maze.length; i++) {
      for (int j = 0; j < maze[i].length; j++) {
        if (maze[i][j] == 'W') {
          //fill(51, 51, 255);
          //rect(j*20, (i+down)*20, 20, 20);
          helperDisplay(j, i);
        } else if (maze[i][j] == 'V') {
          fill(0);
          rect(j*20, (i+down)*20, 20, 20);
        } else if (maze[i][j] == 'S') {
          boxBackground(j, i);
        } else if (maze[i][j] == 'G') {
          fill(255, 153, 204);
          rect(j*20, (i+down)*20 + 6, 20, 8);
        } else if (maze[i][j] == 'P') {
          boxBackground(j, i);
          fill(255, 128, 128);
          ellipse(j*20 + 10, (i+down)*20 + 10, 15, 15);
        } else if (maze[i][j] == 'D') {
          boxBackground(j, i);
          fill (255, 245, 235);
          float offset = 6;
          rect(j*20 + ((20-offset)/2), (i+down)*20 + ((20-offset)/2), offset, offset);
        } else if (maze[i][j] == 'd' || maze[i][j] == 'p') {
          boxBackground(j, i);
        } else if (maze[i][j] == 'f') {
          PImage cherry = loadImage("cherry.png");
          boxBackground(j, i);
          image(cherry, j*20, (i+down)*20, 20, 20);
          for (int z = 0; z < cherry.width; z++) {
            for (int w = 0; w < cherry.height; w++) {
              color c = cherry.get(z, w);
              if(red(c) == 247 && blue(c) == 247 && green(c) == 247){
                color n = color(255, 245, 235);
                cherry.set(z,w,n);
              }
            }
          }
        }
      }
    }
    textSize(20);
    fill(255);
    // experiment with PFont later
    text("1UP", 60, 20);
    text("HIGH SCORE " + highScore, 200, 20); 
    text("SCORE " + score, 160, 40);
    fill(255, 255, 0);
    // lives left, you are using one of your lives
    for (int i = 1; i < lives; i++) {
      arc(40*i, 700, 25, 25, 7*SIXTH_PI, 17*SIXTH_PI, PIE);
    }
  }

  private void boxBackground(int x, int y) {
    fill(128);
    rect(x*20, (y+down)*20, 20, 20);
  }

  int getScore() {
    return score;
  }

  void setScore(int s) {
    score = s;
  }

  int getLives() {
    return lives;
  }

  int getLevel() {
    return level;
  }

  void addLevel(int num) {
    level += num;
  }

  int addLives(int num) {
    lives += num;
    return getLives();
  }

  void addScore(int n) {
    score += n;
  }

  void storeHighScore(String file) {
    try {
      BufferedReader r = createReader(file);
      String x = r.readLine();
      int bestScore = Integer.parseInt(x);
      if (score > bestScore) {
        PrintWriter output;
        output = createWriter("data/"+file);
        output.println(score);
        output.close();
      }
    }
    catch (IOException ex) {
      ex.printStackTrace();
    }
  }

  void refillFood() {
    for (int i = 0; i < maze.length; i++) {
      for (int j = 0; j < maze[i].length; j++) {
        if (maze[i][j] == 'd') maze[i][j] = 'D';
        if (maze[i][j] == 'p') maze[i][j] = 'P';
      }
    }
  }

  boolean containsNoFood() {
    for (int i = 0; i < maze.length; i++) {
      for (int j = 0; j < maze[i].length; j++) {
        if (maze[i][j] == 'D' || maze[i][j] == 'P') return false;
      }
    }
    return true;
  }

  char get(int xV, int yV) {
    //if (xV < 0 || yV < 0 || xV >= maze.length  || yV >= maze[0].length) {
    //  println(xV + " " + yV);
    //  return '0';
    //}
    return maze[xV][yV];
  }

  boolean isValid(int row, int col, boolean isPac) {
    if (row >= maze.length || maze[0].length <= col || row < 0 || col < 0) return false;
    //println(row + " " + col);
    char c = maze[row][col];
    // println("Char: " + c);
    if (isPac && c == 'G') return false;
    if (c == 'W' || c == 'V') return false;
    //return c == 'P' || c == 'D' || c == 'p' || c == 'd' || c == 'S';
    return true;
  }

  void respawn() {
    lives --;
    p = new Pacman(23, 13, 12);
    ghosts.set(0, new Ghost(15, 12, 20, color(255, 0, 0))); // red
    ghosts.set(1, new Ghost(15, 13, 18, color(255, 184, 255))); // brilliant lavender
    ghosts.set(2, new Ghost(15, 14, 20, color(0, 255, 255))); // aqua
    ghosts.set(3, new Ghost(15, 15, 20, color(255, 184, 82))); // pastel orange
  }

  void set(int xPos, int yPos, char c) {
    maze[xPos][yPos] = c;
  }

  void gameOverDisplay() {
    displayMaze();
    fill(255);
    text("GAME OVER", 220, 560);
  }

  boolean over() {
    return gameOver;
  }

  /*
  Code below this is used for displaying walls as close to the originals as possible.
   Yes the code is terrible with so many booleans
   Code can be made better by moving repeating booleans to one and just using if
   Although the draw back is a lack of understanding which block it is refering to
   */
  private void helperDisplay(int j, int i) {
    fill(51, 51, 255);
    if (wallSurround(j, i)) {
      // let it be darkness
    } else if (dotI(j, i)) {
      rect(j*20, (i+down)*20+8, 10, 4);
      rect(j*20+8, (i+down)*20+11, 4, 10);
    } else if (dotII(j, i)) {
      rect(j*20+8, (i+down)*20+11, 4, 10);
      rect(j*20+11, (i+down)*20+8, 10, 4);
    } else if (dotIII(j, i)) {
      rect(j*20+8, (i+down)*20, 4, 10);
      rect(j*20+11, (i+down)*20+8, 10, 4);
    } else if (dotIV(j, i)) {
      rect(j*20+8, (i+down)*20, 4, 10);
      rect(j*20, (i+down)*20+8, 10, 4);
    } else if (houseUp(j, i) || houseDown(j, i)) {
      rect(j*20, (i+down)*20+8, 20, 4);
    } else if (houseRight(j, i) || houseLeft(j, i)) {
      rect(j*20+8, (i+down)*20, 4, 20);
    } else if (quadIV(j, i)) {
      rect(j*20+8, (i+down)*20, 4, 10);
      rect(j*20, (i+down)*20+8, 10, 4);
    } else if (quadI(j, i)) {
      rect(j*20, (i+down)*20+8, 10, 4);
      rect(j*20+8, (i+down)*20+11, 4, 10);
    } else if (quadIII(j, i)) {
      rect(j*20+8, (i+down)*20, 4, 10);
      rect(j*20+11, (i+down)*20+8, 10, 4);
    } else if (quadII(j, i)) {
      rect(j*20+8, (i+down)*20+11, 4, 10);
      rect(j*20+11, (i+down)*20+8, 10, 4);
    } else if (i == 0 && j == 0) {
      rect(j*20+8, (i+down)*20+11, 4, 10);
      rect(j*20+11, (i+down)*20+8, 10, 4);
      rect(j*20, (i+down)*20+4, 4, 16);
      rect(j*20+4, (i+down)*20, 16, 4);
    } else if (j == 0) {
      rect(j*20, (i+down)*20, 4, 20);
      rect(j*20 + 8, (i+down)*20, 4, 20);
    } else if (i == 0 || notWallHor(j, i)) {
      rect(j*20, (i+down)*20, 20, 4);
      rect(j*20, (i+down)*20 + 8, 20, 4);
    } else {
      rect(j*20, (i+down)*20, 20, 20);
    }
  }

  private boolean wallSurround(int j, int i) {
    if (i == 0 || i == maze.length - 1 || j == 0 || j == maze[0].length - 1) return false;
    boolean l = get(i, j-1) == 'W'; 
    boolean r = get(i, j+1) == 'W';
    boolean u = get(i-1, j) == 'W';
    boolean d = get(i+1, j) == 'W';
    boolean IV = get(i+1, j+1) == 'W';
    boolean III = get(i+1, j-1) == 'W';
    boolean II = get(i-1, j-1) == 'W';
    boolean I = get(i-1, j+1) == 'W';
    return l && r && u && d && I && II && III && IV;
  }

  private boolean houseUp(int j, int i) {
    if (i == 0 || i == maze.length - 1 || j == 0 || j == maze[0].length - 1) return false;
    boolean l = get(i, j-1) == 'W'; 
    boolean r = get(i, j+1) == 'W';
    boolean u = get(i-1, j) == 'W';
    boolean I = get(i-1, j+1) == 'W';
    boolean II = get(i-1, j-1) == 'W';
    return l && r && u && I && II;
  }

  private boolean houseDown(int j, int i) {
    if (i == 0 || i == maze.length - 1 || j == 0 || j == maze[0].length - 1) return false;
    boolean l = get(i, j-1) == 'W'; 
    boolean r = get(i, j+1) == 'W';
    boolean d = get(i+1, j) == 'W';
    boolean IV = get(i+1, j+1) == 'W';
    boolean III = get(i+1, j-1) == 'W';
    return l && r && d && IV && III;
  }

  private boolean houseLeft(int j, int i) {
    if (i == 0 || i == maze.length - 1 || j == 0 || j == maze[0].length - 1) return false;
    boolean l = get(i, j-1) == 'W'; 
    boolean u = get(i-1, j) == 'W';
    boolean d = get(i+1, j) == 'W';
    boolean III = get(i+1, j-1) == 'W';
    boolean II = get(i-1, j-1) == 'W';
    return l && u && d && II && III;
  }

  private boolean houseRight(int j, int i) {
    if (i == 0 || i == maze.length - 1 || j == 0 || j == maze[0].length - 1) return false;
    boolean r = get(i, j+1) == 'W';
    boolean u = get(i-1, j) == 'W';
    boolean d = get(i+1, j) == 'W';
    boolean IV = get(i+1, j+1) == 'W';
    boolean I = get(i-1, j+1) == 'W';
    return r && u && d && IV & I;
  }

  private boolean quadIV(int j, int i) {
    if (i == 0 || i == maze.length - 1 || j == 0 || j == maze[0].length - 1) return false;
    boolean l = get(i, j-1) == 'W';
    boolean u = get(i-1, j) == 'W';
    boolean II = get(i-1, j-1) == 'W';
    return l && u && II;
  }

  private boolean quadI(int j, int i) {
    if (i == 0 || i == maze.length - 1 || j == 0 || j == maze[0].length - 1) return false;
    boolean l = get(i, j-1) == 'W'; 
    boolean d = get(i+1, j) == 'W';
    boolean III = get(i+1, j-1) == 'W';
    return l && d && III;
  }

  private boolean quadIII(int j, int i) {
    if (i == 0 || i == maze.length - 1 || j == 0 || j == maze[0].length - 1) return false;
    boolean r = get(i, j+1) == 'W';
    boolean u = get(i-1, j) == 'W';
    boolean I = get(i-1, j+1) == 'W';
    return r && u && I;
  }

  private boolean quadII(int j, int i) {
    if (i == 0 || i == maze.length - 1 || j == 0 || j == maze[0].length - 1) return false;
    boolean r = get(i, j+1) == 'W';
    boolean d = get(i+1, j) == 'W';
    boolean IV = get(i+1, j+1) == 'W';
    return r && d && IV;
  }

  private boolean dotI(int j, int i) {
    if (i == 0 || i == maze.length - 1 || j == 0 || j == maze[0].length - 1) return false;
    boolean l = get(i, j-1) == 'W'; 
    boolean d = get(i+1, j) == 'W';
    boolean III = isValid(i+1, j-1, false);
    return l && d && III;
  }

  private boolean dotII(int j, int i) {
    if (i == 0 || i == maze.length - 1 || j == 0 || j == maze[0].length - 1) return false;
    boolean r = get(i, j+1) == 'W';
    boolean d = get(i+1, j) == 'W';
    boolean IV = isValid(i+1, j+1, false);
    return r && d && IV;
  }

  private boolean dotIII(int j, int i) {
    if (i == 0 || i == maze.length - 1 || j == 0 || j == maze[0].length - 1) return false;
    boolean r = get(i, j+1) == 'W';
    boolean u = get(i-1, j) == 'W';
    boolean I = isValid(i-1, j+1, false);
    return r && u && I;
  }

  private boolean dotIV(int j, int i) {
    if (i == 0 || i == maze.length - 1 || j == 0 || j == maze[0].length - 1) return false;
    boolean l = get(i, j-1) == 'W';
    boolean u = get(i-1, j) == 'W';
    boolean II = isValid(i-1, j-1, false);
    return l && u && II;
  }
  private boolean notWallHor(int j, int i) {
    if (i == 0 || i == maze.length - 1 || j == 0 || j == maze[0].length - 1) return false;
    boolean u = get(i-1, j) != 'W';
    boolean d = get(i+1, j) != 'W';  
    return u && d;
  }

  private boolean notWallVert(int j, int i) {
    return true;
  }
}
