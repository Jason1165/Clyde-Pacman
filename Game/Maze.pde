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
          rect(j*20, (i+down)*20 + 8, 20, 12);
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
          for (int z = 0; z < cherry.width; z++) {
            for (int w = 0; w < cherry.height; w++) {
              color c = cherry.get(z, w);
              if (red(c) == 247 && blue(c) == 247 && green(c) == 247) {
                color n = color(128);
                cherry.set(z, w, n);
              }
            }
          }
          image(cherry, j*20, (i+down)*20, 20, 20);
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
    char c = maze[row][col];
    if (isPac && c == 'G') return false; // pacman cannot enter wall
    if (c == 'W') return false;
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
    text("GAME OVER", 220, 565);
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
    boolean border = !(i == 0 || i == maze.length - 1 || j == 0 || j == maze[0].length - 1);
    if (border) {
      boolean l = get(i, j-1) == 'W'; 
      boolean r = get(i, j+1) == 'W';
      boolean u = get(i-1, j) == 'W';
      boolean d = get(i+1, j) == 'W';
      boolean IV = get(i+1, j+1) == 'W';
      boolean III = get(i+1, j-1) == 'W';
      boolean II = get(i-1, j-1) == 'W';
      boolean I = get(i-1, j+1) == 'W';
      boolean lV = isValid(i, j-1, false); 
      boolean rV = isValid(i, j+1, false);
      boolean uV = isValid(i-1, j, false);
      boolean dV = isValid(i+1, j, false);
      boolean IVdot = isValid(i+1, j+1, false);
      boolean IIIdot = isValid(i+1, j-1, false);
      boolean IIdot = isValid(i-1, j-1, false);
      boolean Idot = isValid(i-1, j+1, false);
      if (l && r && u && d && I && II && III && IV) {
        // its an inner wall surrounded by walls
      } else if (get(i+1, j) == 'V') {
        rect(j*20, (i+down)*20+8, 20, 4);
        rect(j*20, (i+down)*20+16, 20, 4);
      } else if (get(i-1, j) == 'V') {
        rect(j*20, (i+down)*20, 20, 4);
        rect(j*20, (i+down)*20+8, 20, 4);
      } else if (get(i, j+1) == 'V') {
        rect(j*20+8, (i+down)*20, 4, 20);
        rect(j*20+16, (i+down)*20, 4, 20);
      } else if (get(i, j-1) == 'V') {
        rect(j*20, (i+down)*20, 4, 20);
        rect(j*20+8, (i+down)*20, 4, 20);
      } else if ((l && d && IIIdot) || (rV && uV && Idot)) {
        // top right corner
        rect(j*20, (i+down)*20+8, 10, 4);
        rect(j*20+8, (i+down)*20+11, 4, 10);
      } else if ((r && d && IVdot) || (lV && uV && IIdot)) {
        // top left corner
        rect(j*20+8, (i+down)*20+11, 4, 10);
        rect(j*20+11, (i+down)*20+8, 10, 4);
      } else if ((r && u && Idot) || (IIIdot && lV && dV)) {
        // bottom left corner
        rect(j*20+8, (i+down)*20, 4, 10);
        rect(j*20+11, (i+down)*20+8, 10, 4);
      } else if ((l && u && IIdot) || (IVdot && rV && dV)) {
        // bottom right corner
        rect(j*20+8, (i+down)*20, 4, 10);
        rect(j*20, (i+down)*20+8, 10, 4);
      } else if (l && r && u && I && II || l && r && d && IV && III) {
        // house up and down
        rect(j*20, (i+down)*20+8, 20, 4);
      } else if (r && u && d && IV & I || l && u && d && II && III) {
        // house left and right
        rect(j*20+8, (i+down)*20, 4, 20);
      } else if (l && u && II) {
        // bottom right corner
        rect(j*20+8, (i+down)*20, 4, 10);
        rect(j*20, (i+down)*20+8, 10, 4);
      } else if (l && d && III) {
        // top tight corner
        rect(j*20, (i+down)*20+8, 10, 4);
        rect(j*20+8, (i+down)*20+11, 4, 10);
      } else if (r && u && I) {
        // bottom right corner
        rect(j*20+8, (i+down)*20, 4, 10);
        rect(j*20+11, (i+down)*20+8, 10, 4);
      } else if (r && d && IV) {
        // bottom left corner
        rect(j*20+8, (i+down)*20+11, 4, 10);
        rect(j*20+11, (i+down)*20+8, 10, 4);
      } else {
        rect(j*20, (i+down)*20, 20, 20);
      }
    } else {
      if (j == 0 && (i == 0 || i == 19)) {
        rect(j*20+8, (i+down)*20+12, 4, 8);
        rect(j*20+12, (i+down)*20+8, 8, 4);
        rect(j*20, (i+down)*20+4, 4, 16);
        rect(j*20+4, (i+down)*20, 16, 4);
      } else if (j == maze[0].length - 1 && (i == 0 || i == 19)) {
        rect(j*20, (i+down)*20, 16, 4);
        rect(j*20+16, (i+down)*20 + 4, 4, 16);
        rect(j*20, (i+down)*20 + 8, 8, 4);
        rect(j*20 + 8, (i+down)*20 + 12, 4, 8);
      } else if (j == 0 && (i == maze.length - 1 || i == 9)) {
        rect(j*20, (i+down)*20, 4, 16);
        rect(j*20+8, (i+down)*20, 4, 8);
        rect(j*20+4, (i+down)*20+16, 16, 4);
        rect(j*20+12, (i+down)*20+8, 8, 4);
      } else if (j == maze[0].length - 1 && (i == maze.length-1 || i == 9)) {
        rect(j*20+16, (i+down)*20, 4, 16);
        rect(j*20, (i+down)*20+16, 16, 4);
        rect(j*20 + 8, (i+down)*20, 4, 8);
        rect(j*20, (i+down)*20 + 8, 8, 4);
      } else if (j == 0 && i == 24) {
        rect(j*20, (i+down)*20, 4, 20);
        rect(j*20+8, (i+down)*20, 4, 8); 
        rect(j*20+12, (i+down)*20+8, 8, 4);
      } else if (j == 0 && i == 25) {
        rect(j*20, (i+down)*20, 4, 20);
        rect(j*20+8, (i+down)*20+12, 4, 8); 
        rect(j*20+12, (i+down)*20+8, 8, 4);
      } else if (j == maze[0].length - 1 && i == 24) {
        rect(j*20+16, (i+down)*20, 4, 20);
        rect(j*20+8, (i+down)*20, 4, 8); 
        rect(j*20, (i+down)*20+8, 8, 4);
      } else if (j == maze[0].length - 1 && i == 25) {
        rect(j*20+16, (i+down)*20, 4, 20);
        rect(j*20+8, (i+down)*20+12, 4, 8); 
        rect(j*20, (i+down)*20+8, 8, 4);
      } else if (i != 0 && get(i-1, j) == 'V') {
        rect(j*20, (i+down)*20, 20, 4);
        rect(j*20, (i+down)*20+8, 20, 4);
      } else if (i != maze.length - 1 && get(i+1, j) == 'V') {
        rect(j*20, (i+down)*20+8, 20, 4);
        rect(j*20, (i+down)*20+16, 20, 4);
      } else if (j == 0) {
        rect(j*20, (i+down)*20, 4, 20);
        rect(j*20 + 8, (i+down)*20, 4, 20);
      } else if (i == 0) {
        rect(j*20, (i+down)*20, 20, 4);
        rect(j*20, (i+down)*20 + 8, 20, 4);
      } else if (i == maze.length - 1) {
        rect(j*20, (i+down)*20 + 8, 20, 4);
        rect(j*20, (i+down)*20 + 16, 20, 4);
      } else if (j == maze[i].length - 1) {
        rect(j*20 + 16, (i+down)*20, 4, 20);
        rect(j*20 + 8, (i+down)*20, 4, 20);
      }
    }
  }
}
