public class Blinky extends Ghost {
  Blinky() {
    super(15, 12, 12 * pow(19.0/20, map.getLevel() - 1), color(255, 0, 0));
    setMode(CAGE);
  }

  void chooseDir() {
    if (mode == CAGE && count % 120 == 0) {
      mode = SCATTER;
    }
    if (mode == CHASE && count % (int)(1200 / (1+map.getLevel()-1)) == 0) {
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
      int len = map.BFS(x + choices.get(0)[0], y + choices.get(0)[1], 1, 26);
      for (int i = 1; i < choices.size(); i++) {
        if (len > map.BFS(x + choices.get(i)[0], y + choices.get(i)[1], 1, 26)) {
          len = map.BFS(x + choices.get(i)[0], y + choices.get(i)[1], 1, 26);
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
      int len = map.BFS(x + choices.get(0)[0], y + choices.get(0)[1], p.getX(), p.getY());
      for (int i = 1; i < choices.size(); i++) {
        if (len > map.BFS(x + choices.get(i)[0], y + choices.get(i)[1], p.getX(), p.getY())) {
          len = map.BFS(x + choices.get(i)[0], y + choices.get(i)[1], p.getX(), p.getY());
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
