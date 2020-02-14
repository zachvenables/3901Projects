# Project 2
### Game of Set

### Roles
* Overall Project Manager: Neil Mckibben
* Coding Manager: Zachary Venables
* Testing Manager: Matthew Kelch
* Documentation: Andrew Petrill

### Contributions
Please list who did what for each part of the project.

Zach Venables: 
Created Player class and Timer class
Provided all testing for player and Timer class

Andrew Petrilli:
Created Hint_Generator class and Card class
Provided all testing for Hint_Generator and Card

Matt Kelch:
Created main-gui and Board class,
Provided all testing for Board class and test plan for the GUI

Neil McKibben:
Created Deck class and worked with main_gui
Provided all tests for Deck

Sean Simpson:
Created Logic class and Computer Class
Provided testing for logic class and computer class


Also list if people worked together (pair programmed) on a particular section.
N/a

### Project description
 Our project is the card game Set.  The basic game, three cards make up a "set", which a player collects by making sure 
 each of those three cards has exactly the same matching feature or else all have a different feature. If two cards 
 match in one of the four features, but the third card does not, then the three cards are not a "set".
 
 When the game is launched you can input your name.  Then you are asked to play with an AI.  If you would like an 
 Opponent, type "yes", otherwise, type "no"
 
 You are then prompted for a difficulty.  Based on the difficulty, you will have varying amounts of time before you are deducted points (single player game) or before the AI finds a set (AI game).
 
 In a 2 player game, the AI will attempt to make a set after 120 seconds, 60 seconds, or 30 seconds depending on the difficulty. However, the AI is sometimes wrong and will lose points just like the player!
 
 Now you have entered the game. Make sure you maximize your window for the ultimate gaming experience.
 
 We have built the game so that there IS  a set on the board.  If you can not find one, use the hint buttons at the top.
 
 ### Notes
 Gaps may appear on the board when there are more than 12 cards. This is intentional to make sure that cards don't shift around and confuse players.
 
 When clicking one of the hint buttons, you will be prompted with numbers that make up a set. These numbers refer to the indices of the cards on the board, from left-to-right, top-to-bottom, and starting with index 0. Furthermore, these indices will count blank spaces in the board, so be sure to count blank spaces when using a hint!
 
 ### HOW TO RUN
 1. Download the file "Project-2-CODE-BOIZ-x86_64.run" from the repository onto your Linux computer
 2. In terminal, navigate to wherever you downloaded the above file
 3. Give yourself executable permission for the file: `sudo chmod +x Project-2-CODE-BOIZ-x86_64.run`
 4. Run the executable: `./Project-2-CODE-BOIZ-x86_64.run`
 5. If Shoes is not installed on your machine, the executable will download a temporary copy for the game
