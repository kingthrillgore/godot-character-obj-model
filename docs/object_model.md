The Character Object model can be described in the UML diagram below.

![UML chart for Character Object Model](https://i.imgur.com/4GGeK2Z.png)

# Character

The Super for all of the classes below.

At the least, it should define:

*Name

## Player

The player pawn in the game world. This will extend from Character.

## Enemy

Any enemy pawn in the game world. Each enemy below it will ideally be linked to
this Class as its parent. Enemy pawns, like the player, will be able to fight
and involve themselves in combat.

## NPC

NPC is the generic Class for any non-enemy character in the game world. These
kind of pawns typically encompass three unique classes i've been able to
identify, listed below:

* Merchant
* Generic
* Quest Manager

NPCs, unlike Enemy entities, do not engage in combat.

### Merchant

Merchants are NPCs that are typically found running some kind of store or
market.

### Generic

Generic NPCs typically exist as dialog fodder or exist for other purposes in
the world.

### Quest Manager

Quest Manager NPCs give and update quests. They can share the same
functionality as any other NPC, but can award the player for quests completed.

## Attributes (Include Class in Character)

Attributes defines the attributes used by Characters. This could include Hit
Points, Psi Points, and so forth. I am not fully clear on how to best abstract
this.

## Inventory (Include Class in Inventory)

Inventory serves as the Singleton for the character's active inventory. This is
mostly directed at the Player and could even be attached strictly to that
class, but Inventory re-use allows Enemies to have items that can be claimed
when they die.
