# Attack Power

The player, and other pawns in the game world have a single measure of weapon **attack power** *(AT)* that dictates the power of attack capabilities. It is a core measurement for which weapon damage is determined per-attack.

This system is currently being fine tuned.

## Math for Attack Power

On character creation, the initial Attack Power is set based on the following math:

$$ AT = \lfloor Strength * 2.5 \rfloor  $$

On Level up, additional AT is added based on the following formula

$$New \ AT = Old \ AT + (({1 \over 2}) \lfloor(3..20)\rfloor) $$

Where $$ \lfloor(3..20)\rfloor $$ is essentially a 1d20 roll.
