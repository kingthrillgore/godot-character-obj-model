# Character Class

extends Node
var AttributesObj = preload("res://Attributes.gd")
var InvObj = preload("res://Inventory.gd")
var Attributes = AttributesObj.new()
var Inventory = InvObj.new()

# Character defining attributes
var CharacterName = ""
var CharacterLevel = 0
var CharacterExperiencePoints = 0
var HitPoints = 0
var MaxHitPoints = 0
var AbilityPoints = 0
var MaxAbilityPoints = 0
var Potential = 0
var RecoveredHitPoints = 0
var RecoveredAbilityPoints = 0

# Constants
const MAX_LEVEL = 25

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func SetGameStartAttributes():
	"""
	Set up initial attributes for the character (stubbed function). You could
    easily also do this in any Inherited or Reference class.
	"""
	# TODO
	pass

func SetPlayerName(name):
	"""
	Set player name. If a value that is not a string, or an empty string is set,
	the method returns false.

	Keyword arguments:
	name -- The name of the character in a String form. (Required)
	"""
	if typeof(name) != TYPE_STRING:
		return false

	if name.empty() == true:
		return false

	CharacterName = name
	return CharacterName

func GetPlayerName():
	"""
	Returns player name.
	"""
	return CharacterName

func SetPrimaryStats(Const, Str, Int, Per, Prov):
	"""
	Set the player primary stats. All primary stats must be defined as
	non negative integers, or else the method will return false. They can be
	defined as zero.

    For Information on the Primary Statistics, please see the documentation
    in the `docs` folder.

	Keyword arguments:
	Const -- Representation of Constitution (Required)
	Str -- Representation of Strength (Required)
	Int -- Representation of Intelligence (Required)
	Per -- Representation of Perception (Required)
	Prov -- Representation of Providence (Required)
	"""
	if typeof(Const) != TYPE_INT \
		and typeof(Str) != TYPE_INT \
		and typeof(Int) != TYPE_INT \
		and typeof(Per) != TYPE_INT \
		and typeof(Prov) != TYPE_INT:
			return false

	if Const >= 0 \
		and Str >= 0 \
		and Int >= 0 \
		and Per >= 0 \
		and Prov >= 0:
			return false

	Attributes.set_constitution(Const)
	Attributes.set_strength(Str)
	Attributes.set_intelligence(Int)
	Attributes.set_perception(Per)
	Attributes.set_providence(Prov)
	return true

func SetNonStatusDerivedStats():
	"""
	Sets all the derived statistics not HP or Ability Points
	"""
	# TODO

func SetHitPoints():
	"""
	Set the initial Hit Points on creation
	"""
	self.HitPoints = (Attributes.get_constitution() * 15) + floor((1.5 * Attributes.get_strength()))
	self.MaxHitPoints = HitPoints
	return self.HitPoints

func AddHitPoints(delta):
	"""
	Add hit points passed through as a delta. This operation is
	intended to be used when Healing or Recovery operations are being used
	by the player.

	If the delta is not defined, or is a negative integer the
	argument returns false.

	If the delta leads the new total to exceed the maximum Hit Points
	possible, then return the Maximum Hit Points.

	Keyword arguments:
	delta -- An integer representing Hit Points to be added to the
	character (Required)
	"""

	if typeof(delta) == TYPE_INT and delta > -1:
		RecoveredHitPoints = HitPoints + delta
		if RecoveredHitPoints >= MaxHitPoints:
			HitPoints = MaxHitPoints
			return HitPoints
		else:
			HitPoints = RecoveredHitPoints
			return HitPoints
	else:
		return false

func IncreaseHitPoints(delta):
	"""
	Add hit points passed through as a delta. This operation is
	intended to be used when Leveling Up, or other stat-boosting
	operations are being used by the player or the character. Any math that
	must be run to calculate what the Delta is obviously needs to be done
	before you run this method.

	If the delta is not defined, the argument returns false.

	Keyword arguments:
	delta -- An integer representing Hit Points to be added to the
	character. (Required)
	"""
	if typeof(delta) == TYPE_INT and delta >= 0:
		MaxHitPoints = MaxHitPoints + delta;
		HitPoints = MaxHitPoints
		return HitPoints
	else:
		return false

func RemoveHitPoints(delta):
	"""
	Remove hit points passed through as a delta.

	If delta is not defined, the argument returns false, changing nothing.

	Keyword arguments:
	delta -- An integer representing Hit Points to be removed from the
	character. (Required)
	"""
	if typeof(delta) == TYPE_INT and delta >= 0:
		HitPoints = HitPoints - delta
	else:
		return false

func GetCurrentHitPoints():
	"""
	Returns the current Hit Points for the Character
	"""
	return HitPoints

func GetMaxHitPoints():
	"""
	Returns the maximum number of Hit Points
	"""
	return MaxHitPoints

func SetAbilityPoints():
	"""
	Set the initial Ability Points on creation
	"""
	AbilityPoints = (4 * Attributes.get_intelligence()) + floor((1.5 * Attributes.get_perception()))
	MaxAbilityPoints = AbilityPoints
	return AbilityPoints

func AddAbilityPoints(delta):
	"""
	Add ability points passed through as a delta. This operations is
	intended to be used when Recovery operations are being used by the
	player.

	If the delta is not defined, the argument returns false.

	If the delta leads the new total to exceed the maximum Ability Points
	possible, then return the Maximum Ability Points.

	Keyword arguments:
	delta -- An integer representing Ability Points to be added to the
	character (Required)
	"""
	if typeof(delta) == TYPE_INT and delta >= 0:
		RecoveredAbilityPoints = AbilityPoints + delta
		if RecoveredAbilityPoints >= MaxAbilityPoints:
			AbilityPoints = MaxAbilityPoints
			return AbilityPoints
		else:
			AbilityPoints = RecoveredAbilityPoints
			return HitPoints
	else:
		return false

func IncreaseAbilityPoints(delta):
	"""
	Add ability points passed through as a delta. This operation is
	intended to be used when Leveling Up, or other stat-boosting
	operations are being used by the player or the character. Any math that
	must be run to calculate what the Delta is obviously needs to be done
	before you run this method.

	If the delta is not defined, the argument returns false.

	Keyword arguments:
	delta -- An integer representing Ability Points to be added to the
	character. (Required)
	"""
	if typeof(delta) == TYPE_INT and delta >= 0:
		MaxAbilityPoints = MaxAbilityPoints + delta;
		AbilityPoints = MaxAbilityPoints
		return AbilityPoints
	else:
		return false

func RemoveAbilityPoints(delta):
	"""
	Remove ability points passed through as a delta. If delta is not
	defined, the argument returns false, changing nothing.

	Keyword arguments:
	delta -- An integer representing Ability Points to be removed
	from the character. (Required)
	"""
	if typeof(delta) == TYPE_INT and delta >= 0:
		AbilityPoints = AbilityPoints - delta;
		return AbilityPoints;
	else:
		return false

func GetCurrentAbilityPoints():
	"""
	Returns the current total of Ability Points for the Character
	"""
	return AbilityPoints

func ReturnMaxAbilityPoints():
	"""
	Returns the Maximum available Ability Points
	"""
	return MaxAbilityPoints

func SetInitialCharacterLevel():
	"""
	Sets Character Level to 1
	"""
	CharacterLevel = 1
	return CharacterLevel

func IncreaseCharacterLevel():
	"""
	Increments the Character Level by 1, unless it hits its potential max, 25.
	"""
	if CharacterLevel != MAX_LEVEL:
		CharacterLevel = CharacterLevel + 1;
	return CharacterLevel

func SetCharacterPotential():
	"""
	Calculates the Character's Potential. This operation is run when new
	equipment is attached, a level is gained, and so forth.
	"""
	#TODO last method once the rest are in place.

func SetExperiencePoints():
	"""
	Sets Experience Points to 0, to start out with.
	"""
	CharacterExperiencePoints = 0;

func AddExperiencePoints(delta):
	"""
	Add experience points passed through as a delta. If delta is
	not defined, the argument returns false, changing nothing.

	Keyword arguments:
	delta -- An integer representing Experience Points to be
	added to the character. (Required)
	"""
	if typeof(delta) == TYPE_INT and delta >= 0:
		CharacterExperiencePoints = CharacterExperiencePoints + delta;
		return CharacterExperiencePoints;
	else:
		return false
