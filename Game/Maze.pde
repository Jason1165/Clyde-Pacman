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

  void displayMaze() {
    noStroke();
    background(0);
    for (int i = 0; i < maze.length; i++) {
      for (int j = 0; j < maze[i].length; j++) {
        if (maze[i][j] == 'W') {
          fill(51, 51, 255);
          rect(j*20, (i+down)*20, 20, 20);
        } 
        else if (maze[i][j] == 'V') {
          fill(0);
          rect(j*20, (i+down)*20, 20, 20);
        }
        else if (maze[i][j] == 'S') {
          boxBackground(j, i);
        } 
        else if (maze[i][j] == 'P') {
          boxBackground(j, i);
          fill(255, 128, 128);
          ellipse(j*20 + 10, (i+down)*20 + 10, 15, 15);
        } 
        else if (maze[i][j] == 'D') {
          boxBackground(j, i);
          fill (255, 245, 235);
          float offset = 6;
          rect(j*20 + ((20-offset)/2), (i+down)*20 + ((20-offset)/2), offset, offset);
        }
      }
    }
    textSize(20);
    fill(255);
    // experiment with PFont later
    text("1UP", 60, 20);
    text("HIGH SCORE", 200, 20); 
    fill(255, 255, 0);
    // one of these looks better ...
    arc(40, 700, 25, 25, 9*EIGHT_PI, 23*EIGHT_PI, PIE); 
    arc(80, 700, 25, 25, 7*SIXTH_PI, 17*SIXTH_PI, PIE); 
  }

  private void boxBackground(int x, int y) {
    fill(128);
    rect(x*20, (y+down)*20, 20, 20);
  }

  int getScore() {
    return score;
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

  void storeHighScore(String file) {
  }
}
