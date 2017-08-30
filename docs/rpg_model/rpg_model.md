# RPG Model

This is a documented model of my game's RPG model, which will explain some stuff you'll find in some of the class files.

## Character Attributes Model

### Primary Statistics
Primary Statistics are split into five categories, comparable to the GURPS or SPECIAL System. All Primary Statistics dictate the attributes of Derived Statistics.

These are set once, during player creation. The player selects the primary stats by assigning points, out of a pool of 20. Once assigned, these cannot be modified again in the game.

#### Constitution (`constitution.md`)
Serves as the base measurement for the player's endurance, vitality, and ability to cope with environmental effects.

#### Strength (`strength.md`)
Serves as the base measurement for the player's attack abilities, their inventory capacity, and stamina.

#### Intelligence (`intelligence.md`)
Serves as the base measurement for the player's intelligence, including the ability to craft, hack, use secondary abilities, manipulate the world, and other characters (persuasion). It also affects trade.

#### Perception (`perception.md`)
Serves as the base measurement for the player's environmental awareness, and sense of the world through their senses.

#### Providence (`providence.md`)
Serves as the base measurement for luck, and critical hits or critical success rates on other factors in the world.

### Derived Statistics
Derived Statistics are the basis for all player stats in the game world. The initial values are generated based off the configuration set forth in Primary Statistics, and some of these will increase, as the player progresses (native progression) ultimately affecting any applicable skills that derive from these per level (and through other means, to be explained later).

#### Hit Points
Measure of amount of damage the player can take. Once this hits 0, the player is dead. This Derived Statistic increases per level.

#### Psi Points
Measure of psionic ability power, and how often this can be used. Once this hits 0, the player will need to recover these. This Derived Statistic increases per level.

#### Attack Power
TBD. This Derived Statistic increases per level.

#### Defense Power
TBD. This Derived Statistic increases per level.

#### Ability Power
TBD. This Derived Statistic increases per level.

#### Agility
TBD. This Derived Statistic increases per level.

#### Inventory Capacity
Measures the maximum size of your inventory. This is a constant statistic.

#### Critical Thinking
TBD. This is a constant statistic.

#### Economics
TBD. This is a constant statistic.

#### Crafting
TBD. This is a constant statistic.

#### Communication
TBD. This Derived Statistic increases per level.

#### Effect Resistance
Measures your resistance to effects in the gameplay world. This derived statistic increases per level.

### Skills
Skills are the main editable tree of the player character. When a Level is gained, points are made available, and the skills can be modified as such. The results of skills factor into gameplay events directly.

### Progression Statistics
Progression Statistics are measurements from the game world, and do not necessarily factor into the above.

#### Potential
A numeric scale of your actual power in the game world. This is adjusted by all statistics, weapons, equipment, and so forth.

#### Experience Points
Measurement of progress in the game world
