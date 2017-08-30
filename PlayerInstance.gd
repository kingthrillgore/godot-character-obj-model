# PlayerInstance.gd
# Singleton to track the player character (YOU) in the game world
extends KinematicBody

# Inherited Classes
var Player = preload("res://Player2.gd");
var PlayerObject = Player.new()

# Constants
const MAX_SLOPE_ANGLE = 45

# Event Methods
func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

# Methods
func InitNewPlayer(Name, Const, Str, Int, Per, Prov):
	"""
	Run on Player Creation. When created, all the known initial settings are
	loaeded into the default serialized PlayerObject, and then preserved in
	PlayerInstance throughout the player's session.
	"""
	PlayerObject.SetPlayerName(Name)
	var status = PlayerObject.SetPrimaryStats(Const, Str, Int, Per, Prov)

	# Set Hit Points
	PlayerObject.SetHitPoints()

	# Set Psi Points
	PlayerObject.SetAbilityPoints()

	# Set Initial Character Level
	PlayerObject.SetInitialCharacterLevel()
