# Clyde-Pacman
### Design Document #####
[Googledoc](https://docs.google.com/document/d/1tpnc-Wm02frSSIznljnABScj6-JBMjXSTv66EZFsAFE/edit)

### Compile Instructions

### Development Log
##### 05/23/2022
Both: Sorting out branching and merging.

##### 05/24/2022
Jason: Added on to the skeleton of maze and completed file reading related methods and a basic display of the maze. Added files to data folder for storing information.

Ryan:  Added abstract methods to character interface and created constructor for Pacman class. Made getter and setter methods in Pacman.

##### 05/25/2022
Jason: Created refillFood method and storeHigHScore as well as a few comments for what each char represents in the map.

Ryan: Adjusted some abstract methods in Character and adjusted move methods in pacman class to get pacman to move. Pacman moves crudely in Game class.

##### 05/26/2022
Jason: Completed Ghost class and made ghosts move in a random direction for now. Fixed some methods in Maze where inputs were x which could be confused with this.x.

Ryan: Made small adjustments to data types of instance variables for Pacman class. Made pacman move continuously in the direction of a key press and accounted for boundaries.

##### 05/27/2022
Jason: Improved Ghost's move, it cannot move backwards. Modified Ghost's display and changed it to display at certain coordinates which are calculated in the main.

Ryan: pacman will eat dots and pellets and gain the respective points for them, added set method for score in Maze class and added to display if character in maze was p or d

##### 05/29/2022
Jason: Made some code more concise, made pacman move within the path. Dots can be "eaten".

Ryan: Fixed small boundary issue with gate and made pellets eatable.

##### 05/31/2022
Jason: Worked on making pellets effects work, pacman can eat ghosts for a duration, successive ghosts increase in points. Ghosts that respawn can still be eaten again which needs to be fixed.

Ryan:Added the cherry pgn and adjusted background color. Cherry will appear at a certain spot in the maze that will appear when you get a certain number of points.

##### 06/01/2022
Jason: Worked on making the walls look semi decent or similar to the original game.

Ryan: Made the tunnel working. Both pacman and ghosts can go through and back. The animation is smoothed.

##### 06/02/2022
Jason: Prevented ghost from going back into their cage. Also modified moving for ghosts so future implementation of specific ghosts can be smoother.

Ryan: Fixed the cherry. It will check how many dots pacman has eaten when not spawned. When spawned it will not count the dots.

##### 06/03/2022
Jason: Made function that returns path distance using breadth first search. Using it to help make AI for ghosts.

##### 06/05/2022
Ryan: Added to Pinky file to chase pacman. Not perfect yet, need to test.

##### 06/06/2022
Jason: Working on the AI for Clyde (orange).

Ryan: Cleaned up some code in Pinky and I will work on Inky (blue).

##### 06/07/2022
Ryan: Started working on Inky.

Jason: Added a few keyPress cheats to make dying faster. Modify addLevel so speed of characters increased.

##### 06/09/2022
Ryan: added more keyPress cheats to display ghosts seperately. Will work on showing the square targeted by each ghost.
