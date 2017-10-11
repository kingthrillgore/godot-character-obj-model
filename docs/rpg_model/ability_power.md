# Ability Power

The player, and other pawns in the game world have a single measure of **ability power** *(AB)* that dictates the power of psionic abilities. It is a core measurement for how effective abilities are.

This system is currently being fine tuned.

## Math for Ability Power

On character creation, the initial Ability Power is set based on the following math:

```katex
$$ AB = Intelligence + (({1 \over 2})(\lfloor(Providence)(1.5)\rfloor)  $$
```

On Level up, additional AT is added based on the following formula

```katex
$$New \ AB = Old \ AB + \lfloor(({1 \over 2}) (3..20)) \rfloor $$
```

Where `$$ \lfloor(3..20)\rfloor $$` is essentially a 1d20 roll.
