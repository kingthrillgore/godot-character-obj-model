
extends "res://scripts/Character.gd"

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

static func CreateNewPlayer(PlayerName, Const, Str, Int, Per, Luck):
	"""
	Create a new player instance
	"""
	SetPlayerName(PlayerName)
	SetPrimaryStats(Const, Str, Int, Per, Luck)
	SetHitPoints()
	SetAbilityPoints()
	SetNonStatusDervicedStats()
	SetInitialCharacterLevel()

func returnPlayerName():
	"""
	Returns Player Name
	"""