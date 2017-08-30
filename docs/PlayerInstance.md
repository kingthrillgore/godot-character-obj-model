# Player Instance

For the purpose of the game demo I was working on, I had decided to use a modified version of the [3rdperson-godot](https://github.com/khairul169/3rdperson-godot) Controller for the Character pawn in the game world. To allow the pawn in the game world to access all the Classes needed for the character, I created `PlayerInstance.gd` to serve as a Singleton that could import said character across Scenes.

Ultimately, the KinematicBody object used by that controller inherits the Object instance part of PlayerInstance.
