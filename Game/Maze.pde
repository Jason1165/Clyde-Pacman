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
