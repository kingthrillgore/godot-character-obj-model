# Implements handlers for the Dice Roll.

extends Node

func _ready():
	pass

func _init():
	rand_seed(OS.get_unix_time() * 1000)

func roll_the_dice(number = 1, sides = 6):
	"""
	Rolls a predetermined number of dice with a set number of sides, returning
	the value it lands on. No weight or other variance tensions are factored in
	during the operation.

	Returns an array with all the dice rolled.

	Keyword arguments:
	number -- Integer representing the number of dice you want
	to roll (defaults to 1).
	sides -- Integer representing the number of sides on each die. Defaults to
	six.
	"""
	var resultSet = []
	for i in range(number):
		resultSet.append(roll_die(sides))
	return resultSet

func roll_die(sides):
	"""
	The actual Dice rolling method. All rolls are random operations dictated by
	the number of sides sent to the method. Godot uses xorshift128 as its PRNG.

	Returns the number rolled, which is 1 <= x <= sides.

	Keyword arguments:
	sides -- Integer value representing the number of sides to be rolled for.
	"""
	var die
	randomize()
	die = range(1,sides)[randi()%range(1,sides).size()]
	return die
