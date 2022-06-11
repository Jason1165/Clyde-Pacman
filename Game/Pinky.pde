public class Pinky extends Ghost {
  Pinky() {
    super(15, 15, 12, color(255, 184, 255));
    setMode(CAGE);
  }

  void chooseDir() {
    if (mode == CAGE) {
      setMode(SCATTER);
    }
    if (mode == CHASE && count % 840 == 0) {
      mode = SCATTER;
    }
    ArrayList<int[]> choices = new ArrayList<int[]>();
    for (int i = 0; i < directional.size(); i++) {
      int[] temp = directional.get(i);
      if (map.isValid(temp[0]+x, temp[1]+y, false) && !oppositeDir(temp[0], temp[1])) {
        choices.add(directional.get(i));
        if (!inCage() && map.get(temp[0]+x, temp[1]+y) == 'G') choices.remove(choices.size()-1);
      }
    }
    if (mode == SCATTER) {
      int best = 0; 
      int len = map.BFS(x + choices.get(0)[0], y + choices.get(0)[1], 1, 1);
      for (int i = 1; i < choices.size(); i++) {
        if (len > map.BFS(x + choices.get(i)[0], y + choices.get(i)[1], 1, 1)) {
          len = map.BFS(x + choices.get(i)[0], y + choices.get(i)[1], 1, 1);
          best = i;
        }
      }
      if (len == 0) {
        mode = CHASE;
      } else {
        newDir[0] = choices.get(best)[0];
        newDir[1] = choices.get(best)[1];
      }
    } 
    if (mode == CHASE) {
      int best = 0; 
      int len = map.BFS(x + choices.get(0)[0], y + choices.get(0)[1], p.getX() + 2 * p.dirX(), p.getY() + 2 * p.dirY());
      for (int i = 1; i < choices.size(); i++) {
        if (len > map.BFS(x + choices.get(i)[0], y + choices.get(i)[1], p.getX() + 2 * p.dirX(), p.getY() + 2 * p.dirY())) {
          len = map.BFS(x + choices.get(i)[0], y + choices.get(i)[1], p.getX() + 2 * p.dirX(), p.getY() + 2 * p.dirY());
          best = i;
        }
      }
      newDir[0] = choices.get(best)[0];
      newDir[1] = choices.get(best)[1];
    } 
    if (mode == FRIGHT) {
      int choice = (int)(Math.random()*choices.size());
      newDir[0] = choices.get(choice)[0];
      newDir[1] = choices.get(choice)[1];
    }
    if (mode == CAGE) {
      for (int i = 0; i < choices.size(); i++) {
        if (inCage(x + choices.get(i)[0], y+choices.get(i)[1])) {
          newDir[0] = choices.get(i)[0];
          newDir[1] = choices.get(i)[1];
        }
      }
    }
  }
}
