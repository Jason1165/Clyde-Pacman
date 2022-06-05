//public class GhostList {
//  ArrayList<Ghost> ghostList;

//  GhostList() {
//    ghostList = new ArrayList<Ghost>();
//    ghostList.add(new Blinky());
//    //ghostList.add(new Pinky());
//    //ghostList.add(new Clyde());
//    //ghostList.add(new Inky());
//    //ghostList.add(new Ghost(15, 13, 12, color(255, 184, 255))); // brilliant lavender
//    //ghostList.add(new Ghost(15, 14, 12, color(0, 255, 255))); // aqua
//    //ghostList.add(new Ghost(15, 15, 12, color(255, 184, 82))); // pastel orange
//  }

//  void tick() {
//    for (int i = 0; i < ghostList.size(); i++) {
//      Ghost g = ghostList.get(i);
//      if (frameCount % g.getSpeed() < 1 && !map.over()) {
//        if (g.getY() == 1 && g.dirY() == -1 && map.get(g.getX(), g.getY()-1) == 'S') {
//          g.setY(28);
//          g.move();
//        } else if (g.getY() == 26 && g.dirY() == 1 && map.get(g.getX(), g.getY()+1) == 'S') {
//          g.setY(0);
//          g.move();
//        } else {
//          ghostList.get(i).move();
//          ghostList.get(i).chooseDir();
//          g.display(g.getY()*20, (g.getX()+down)*20);
//        }
//      } else if (map.over()) {
//        g.display(g.getY()*20, (g.getX()+down)*20);
//      } else {
//        g.display(g.getY()*20 + g.dirY()*(20/g.getSpeed()) * (frameCount%g.getSpeed()), (g.getX()+down)*20 + g.dirX()*(20/g.getSpeed()) * (frameCount%g.getSpeed()));
//      }
//    }
//  }

//  void eaten() {
//    for (int i = 0; i < ghostList.size(); i++) {
//      if (ghostList.get(i).getX() == p.getX() && ghostList.get(i).getY() == p.getY()) {
//        if (!p.ability()) {
//          map.respawn();
//        } else {
//          ghostsKilled += 1;
//          map.addScore((int)(200*(Math.pow(2, ghostsKilled - 1))));
//          ghostList.get(i).setX(14);
//          ghostList.get(i).setY(12);
//        }
//      }
//    }
//  }
//}
