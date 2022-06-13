# Clyde-Pacman
### Jason Lin & Ryan Lee
### Project Description
We plan to make the game Pacman in Processing. There will be a maze in which the player controls the character called Pacman and attempts to eat all the dots in the map and evade four ghosts. The ghosts will move in their own individual manner. If the player comes in contact with a ghost, they will lose a life. A player will start with three lives. As the player eats more dots, the ghosts will become faster, making the game harder. There will be pellets that give the player the ability to consume ghosts for a short duration. In this duration, the ghosts will try to run away from the player and if the player consumes a ghost, the ghost will go back to its spawning point. Whenever the player consumes a certain number of dots, a fruit will spawn in a particular location where the player can consume for extra points.

### Design Document #####
[Googledoc](https://docs.google.com/document/d/1tpnc-Wm02frSSIznljnABScj6-JBMjXSTv66EZFsAFE/edit)

### Compile Instructions
To play the game just open up any of the code files in Processing.

To move Pacman just use the WASD keys or the arrow keys.

#### Buttons
+ **wasd/arrow** - movement
+ **1** - takes away one life, so you can lose faster
+ **2** - makes Pacman twice as fast
+ **3** - makes Pacman 50% slower
+ **x** - Ghosts are set to a faster speed and will "chase" after you. By chase they will use their brains and catch you quickly.
+ **4** - increase level by 1, level modifies speed and duration of effects
+ **5** - decrease level by 1
+ **6** - Display only Blinky, the red ghost. (Press only when all the ghosts are outside the "Cage" or else they may get stuck)
+ **7** - Display only Clyde, the yellow ghost. (Press only when all the ghosts are outside the "Cage" or else they may get stuck)
+ **8** - Display only Pinky, the pink ghost. (Press only when all the ghosts are outside the "Cage" or else they may get stuck)
+ **9** - Display only Inky, the blue ghost, and Blinky, the red ghost. (This is because when Inky chases, it is dependent on the location of Blinky) (Press only when all the ghosts are outside the "Cage" or else they may get stuck)
+ **0** - Bring back all the ghosts if you have pressed any of 6-9.
+ ** ** - (spacebar) If any of 6-9 have been pressed, the square that the designated ghost will target will be highlighted its color.
+ **p** - pauses the game
+ **l** - Pacman eats a power pellet that mimics the actual power pellet for a specific duration of time
+ **c** - Clears the map of any food and places a single food behind Pacman when possible. (Not possible when you respawn and last direction was up or down)

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

##### 06/10/2022
Ryan: target will show on each ghost with space bar press

##### 06/11/2022
Jason: Debugging existing code and modifying certain parameters. Added sprites for the ghosts.

##### 06/12/2022
Jason: A start screenish and clearFood().
