import java.io.*;
import java.util.*;

public class Maze {
  char[][] maze;
  int score;
  int lives;
  int level;
  int highScore;

  Maze(String score, String maze) {
    level = 0;
    lives = 3;
    highScore = getHighScore(score);
    generateMaze(maze);
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
   */
  void displayMaze() {
    noStroke();
    background(0);
    for (int i = 0; i < maze.length; i++) {
      for (int j = 0; j < maze[i].length; j++) {
        if (maze[i][j] == 'W') {
          fill(51, 51, 255);
          rect(j*20, (i+down)*20, 20, 20);
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
        }else if (maze[i][j] == 'd' || maze[i][j] == 'p') {
          boxBackground(j, i);
          fill(255, 128, 128);
        }
        else if(maze[i][j] == 'd' || maze[i][j] == 'p') {
          boxBackground(j, i);
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
        output = createWriter(file);
        output.println(score);
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
<<<<<<< HEAD

  char getObject(int xV, int yV) {
=======
  
  char get(int xV, int yV) {
>>>>>>> dbc908bf19a631423a52151b4b193101abd3fa81
    return maze[xV][yV];
  }

  boolean isValid(int row, int col) {
    if (row >= maze.length || maze[0].length <= col || row < 0 || col < 0) return false;
    //println(row + " " + col);
    char c = maze[row][col];
    // println("Char: " + c);
    if (c == 'W' || c == 'V') return false;
    //return c == 'P' || c == 'D' || c == 'p' || c == 'd' || c == 'S';
    return true;
  }

  void respawn() {
  }

  void setObject(int xV, int yV, char obj) {
    maze[xV][yV] = obj;
  }
  
  void set(int xPos, int yPos, char c) {
    maze[xPos][yPos] = c;
  }
}
