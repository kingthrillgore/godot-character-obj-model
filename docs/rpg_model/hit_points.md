# Hit Points

The player, and other pawns in the game world have a fixed amount of **Hit Points** that dictates their integrity. The amount of hit points is controlled by the player's Constitution attribute.

## Math for the Health System

**On character creation**, the initial Hit Points are assigned based on the following formula

<a href="https://www.codecogs.com/eqnedit.php?latex=HP&space;=&space;(Constitution&space;*&space;15)&space;&plus;&space;\lceil&space;1.5&space;*&space;Strength\rceil" target="_blank"><img src="https://latex.codecogs.com/gif.latex?HP&space;=&space;(Constitution&space;*&space;15)&space;&plus;&space;\lceil&space;1.5&space;*&space;Strength\rceil" title="HP = (Constitution * 15) + \lceil 1.5 * Strength\rceil" /></a>

**On Level up**, additional HP is added based on the following formula

<a href="https://www.codecogs.com/eqnedit.php?latex=HPNew&space;=&space;HPExisting&space;&plus;&space;(({\Theta&space;*&space;Constitution&space;\over&space;2})&space;&plus;&space;5)&space;$$" target="_blank"><img src="https://latex.codecogs.com/gif.latex?HPNew&space;=&space;HPExisting&space;&plus;&space;(({\Theta&space;*&space;Constitution&space;\over&space;2})&space;&plus;&space;5)&space;$$" title="HPNew = HPExisting + (({\Theta * Constitution \over 2}) + 5) $$" /></a>

Where Theta equals a random integer between 1 and 5, to assure that leveling up is never consistent.

<a href="https://www.codecogs.com/eqnedit.php?latex=$$&space;1&space;\leq&space;x&space;\leq&space;5&space;$$" target="_blank"><img src="https://latex.codecogs.com/gif.latex?$$&space;1&space;\leq&space;x&space;\leq&space;5&space;$$" title="$$ 1 \leq x \leq 5 $$" /></a>

## Running the Numbers

For the following example, here is a Level 1 character with 4 Constitution, and 4 Strength. Their total starting HP is 66.

<a href="https://www.codecogs.com/eqnedit.php?latex=66&space;=&space;(4&space;*&space;15)&space;&plus;&space;\lceil&space;1.5&space;*&space;4&space;\rceil" target="_blank"><img src="https://latex.codecogs.com/gif.latex?66&space;=&space;(4&space;*&space;15)&space;&plus;&space;\lceil&space;1.5&space;*&space;4&space;\rceil" title="66 = (4 * 15) + \lceil 1.5 * 4 \rceil" /></a>

When they progress to Level 2, they gain an XP increase with the random seed 4 set for Theta, increasing their HP to 79.

<a href="https://www.codecogs.com/eqnedit.php?latex=79&space;=&space;66&space;&plus;&space;(({4&space;*&space;4&space;\over&space;2})&space;&plus;&space;5)" target="_blank"><img src="https://latex.codecogs.com/gif.latex?79&space;=&space;66&space;&plus;&space;(({4&space;*&space;4&space;\over&space;2})&space;&plus;&space;5)" title="79 = 66 + (({4 * 4 \over 2}) + 5)" /></a>
This process continues up to Level 25, the max level.
