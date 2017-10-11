# Psi Points

The player, and other pawns in the game world have a fixed amount of *Psionic Ability Points* or **Psi Points** that dictates the extent they can use special abilities.

This system is currently being fine tuned.

## Math for the Ability System

**On character creation**, the initial number of Ability Points are assigned based on the following formula:

<a href="https://www.codecogs.com/eqnedit.php?latex=Psi&space;Points&space;=&space;(4&space;*&space;Intelligence)&space;&plus;&space;\lceil&space;1.5&space;*&space;Perception&space;\rceil" target="_blank"><img src="https://latex.codecogs.com/gif.latex?Psi&space;Points&space;=&space;(4&space;*&space;Intelligence)&space;&plus;&space;\lceil&space;1.5&space;*&space;Perception&space;\rceil" title="si Points = (4 * Intelligence) + \lceil 1.5 * Perception \rceil" /></a>

```katex
$$ AP =  (4 * Intelligence) + \lceil 1.5 * Perception \rceil $$
```

**On Level up**, additional AP is added based on the following formula

<a href="https://www.codecogs.com/eqnedit.php?latex=New&space;\&space;Psi&space;\&space;Points&space;=&space;Existing&space;\&space;Psi&space;\&space;Points&space;&plus;&space;(Intelligence&space;*&space;\Theta)" target="_blank"><img src="https://latex.codecogs.com/gif.latex?New&space;\&space;Psi&space;\&space;Points&space;=&space;Existing&space;\&space;Psi&space;\&space;Points&space;&plus;&space;(Intelligence&space;*&space;\Theta)" title="New \ Psi \ Points = Existing \ Psi \ Points + (Intelligence * \Theta)" /></a>

```katex
$$ New \ AP = Existing \ AP + (Intelligence * \Theta) $$
```

Where Theta equals a random integer between 1 and 5, to assure that leveling up is never consistent.

<a href="https://www.codecogs.com/eqnedit.php?latex=1&space;\leq&space;x&space;\leq&space;5" target="_blank"><img src="https://latex.codecogs.com/gif.latex?1&space;\leq&space;x&space;\leq&space;5" title="1 \leq x \leq 5" /></a>

```katex
$$ New \ AP = Existing \ AP + (Intelligence * \Theta) $$
```

## Running the Numbers

For the following example, here is a Level 1 character with 5 Intelligence, and 2 Perception. Their total starting AP is 23.

<a href="https://www.codecogs.com/eqnedit.php?latex=23&space;=&space;(4&space;*&space;5)&space;&plus;&space;\lceil&space;1.5&space;*&space;2&space;\rceil" target="_blank"><img src="https://latex.codecogs.com/gif.latex?23&space;=&space;(4&space;*&space;5)&space;&plus;&space;\lceil&space;1.5&space;*&space;2&space;\rceil" title="23 = (4 * 5) + \lceil 1.5 * 2 \rceil" /></a>

```katex
$$ 23 = (4 * 5) + \lceil 1.5 * 2 \rceil $$
```

When they progress to Level 2, they gain an AP increase with a random seed value, in this case a 5. The new AP total is 48.

<a href="https://www.codecogs.com/eqnedit.php?latex=48&space;=&space;23&space;&plus;&space;(5&space;*&space;5)" target="_blank"><img src="https://latex.codecogs.com/gif.latex?48&space;=&space;23&space;&plus;&space;(5&space;*&space;5)" title="48 = 23 + (5 * 5)" /></a>

```katex
$$ 48 = 23 + (5 * 5) $$
```

This process continues up to Level 25, the max level.
