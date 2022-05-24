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
      println("Throw");
      return 0;
    }
  }

  void generateMaze(String file) {
    try {
      File f = new File(file);
      Scanner in = new Scanner(f);
      ArrayList lines = new ArrayList<String>();
      while (in.hasNextLine()) {
        String x = in.nextLine();
        lines.add(x);
        println("hello");
      }
      in.close();
      maze = new char[lines.size()][];
      //for (int i = 0; i < lines.size(); i++) {
      //  maze[i] = toCharArray(lines.get(i));
      //}
    }
    catch (FileNotFoundException ex) {
      println("Thorw");
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
