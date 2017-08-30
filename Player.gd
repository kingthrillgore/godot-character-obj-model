
extends "res://Character.gd"

func _ready():
	pass

static func CreateNewPlayer(PlayerName, Const, Str, Int, Per, Luck):
	"""
    TODO

	Create a new player instance. Keep in mind that you will need to instance
    the Player instance from whatever controller you use to handle the 
    player. Example code for that is forthcoming.
	"""
	SetPlayerName(PlayerName)
	SetPrimaryStats(Const, Str, Int, Per, Luck)
	SetHitPoints()
	SetAbilityPoints()
	SetNonStatusDervicedStats()
	SetInitialCharacterLevel()

func returnPlayerName():
	"""
    TODO

	Returns Player Name
	"""
