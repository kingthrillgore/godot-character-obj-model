# Contains helper methods intended to be used for Character classes.

extends Node

# Hit Points
func set_hit_points_creation(Con, Srn):
	"""
	Assign initial hit points on character creation. Requires the Consitution
	and Strength be set as non-negative integers. If they aren't set,
	return false.
	
	Keyword Attributes:
	Con -- Character's Constitution. (Required)
	Srn -- Character's Strength (Required)
	"""
	if typeof(Con) != TYPE_INT:
		return false

	if Con >= 0:
		return false

	var HP = (Con * 15) + floor((1.5 * Srn))
	return HP

func set_hit_points_levelup(Con, CurrentMaxHP):
	"""
	Append additional Hit Points on character Level Up, based on the Character's
	Constitution. Requires the Constitution be set to a non-negative integer,
	otherwise returns false.
	
	Keyword Attributes:
	Con -- Character's Constituion (Required)
	CurrentMaxHP -- Current max HP for the character (Required)
	"""
	if typeof(Con) != TYPE_INT or typeof(CurrentMaxHP) != TYPE_INT:
		return false
	
	if Con >= 0:
		return false
	
	var HP = CurrentMaxHitPoints + (((randi()%6+1) / 2) + 5)
	return HP
