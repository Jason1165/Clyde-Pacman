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
      File f = new File(file);
      Scanner in = new Scanner(f);
      int x = in.nextInt();
      in.close();
      return x;
    }
    catch (FileNotFoundException ex) {
      return 0;
    }
  }

  void generateMaze(String file) {
  }
}
