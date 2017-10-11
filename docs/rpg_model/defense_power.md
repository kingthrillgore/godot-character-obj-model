# Defense Power

The player, and other pawns in the game world have a single measure of baseline **Defense Power** *(DP)* that dictates baseline defense from attacks, absorption of attack values, and success of defense-oriented stances and movements.

As most Defensive scenarios will also include the combined defense value from armors and chance effects, this can be seen as the minimum amount of damage that can be absorbed by an attack.

This system is currently being fine tuned.

## Math for Attack Power

On character creation, The baseline DP is calculated from the player's  Constitution, multiplied by one half of Strength.

```katex
$$ DP = Constitution * \lfloor ({1 \over 2} * Strength) \rfloor $$
```

On Level up, a random value from 1 to $$ Strength^2$$ is assigned, and a new DP is calculated. The value selected is floored.

```katex
$$ New \ DP = Old \  DP + \lfloor(1..Strength^2)\rfloor $$
```
