# Contains the flattened Player Class and its related subclasses from
# Character, Attributes, and so forth. This will make for a large file but
# I would rather get something build-ready and then try to address this with
# Inheritance later.

extends Node

var DiceObj = preload("res://Dice.gd")
var CoinFlipObj = preload("res://CoinFlip.gd");

# Character defining attributes
# Origin Character.gd
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

# Origin Attributes.gd
# Primary Attributes
var PAConstitution = 0
var PAStrength = 0
var PAIntelligence = 0
var PAPerception = 0
var PAProvidence = 0

# Derived Statistics
var DSMaxHitPoints = 0
var DSMaxAbilityPoints = 0
var DSAttackPower = 0
var DSDefensePower = 0
var DSAbilityPower = 0
var DSAgility = 0
var DSAbilityAwareness = 0
var DSCriticalDamage = 0
var DSInventoryCapacity = 0
var DSCurrentInventoryUsage = 0
var DSCombatAwareness = 0
var DSCriticalThinking = 0
var DSEconomics = 0
var DSTechnicalProf = 0
var DSCommunication = 0
var DSEffectRes = 0
var DSStamina = 0
var DSFabrication = 0

# TODO Make sure we need these (adding to compile)
var StatusAbilityPoints
var Strength
var CalcAtkPts
var DefPwrMax
var AblPwrDelta
var MaxStrVal
var NewInvUsage
var CraftingRandomAdd

# Constants
const MAX_LEVEL = 25
const INVENTORY_MULTI = 7
const D20_MIN = 1
const D20_MAX = 20

# Methods

# Origin Character.gd
func SetGameStartAttributes():
	"""
	Set up initial attributes for the character (stubbed function)
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

	This does not conduct the mathematical formulation for stat generation. That
	must be done after this method is run.

	Keyword arguments:
	Const -- Representation of Constitution (Required)
	Str -- Representation of Strength (Required)
	Int -- Representation of Intelligence (Required)
	Per -- Representation of Perception (Required)
	Prov -- Representation of Providence (Required)
	"""

	#TODO Fix
	#if typeof(Const) != TYPE_INT \
	#	and typeof(Str) != TYPE_INT \
	#	and typeof(Int) != TYPE_INT \
	#	and typeof(Per) != TYPE_INT \
	#	and typeof(Prov) != TYPE_INT:
	#		return false

	#if Const >= 0 \
	#	and Str >= 0 \
	#	and Int >= 0 \
	#	and Per >= 0 \
	#	and Prov >= 0:
	#		return false

	set_constitution(Const)
	set_strength(Str)
	set_intelligence(Int)
	set_perception(Per)
	set_providence(Prov)
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
	HitPoints = (get_constitution() * 15) + floor((1.5 * get_strength()))
	MaxHitPoints = HitPoints
	return HitPoints

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
	AbilityPoints = (4 * get_intelligence()) + floor((1.5 * get_perception()))
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

# Origin Attributes.gd
# ----
# Primary Statistics Setting/Retrieval Methods
# ----

func set_constitution(con):
	"""
	Sets the points allocated to Constitution. If not an integer, or is set
	to zero, return false.

	Keyword arguments:
	con -- Integer value for Constitution. (Required)
	"""
	if typeof(con) == TYPE_INT:
		if con > 0:
			PAConstitution = con
			return PAConstitution;
		else:
			return false
	else:
		return false

func get_constitution():
	"""
	Returns the number of points set to Constitution
	"""
	return PAConstitution

func set_strength(srn):
	"""
	Sets the points allocated to Strength. If not an integer, or is set to
	zero, return false.

	Keyword arguments:
	srn -- Integer value for Strength (Required)
	"""
	if typeof(srn) == TYPE_INT:
		if srn > 0:
			PAStrength = srn
			return PAStrength
		else:
			return false
	else:
		return false

func get_strength():
	"""
	Returns the number of points set to Strength
	"""
	return PAStrength

func set_intelligence(nti):
	"""
	Sets the points allocated to Intelligence. If not an integer, or is
	set to zero, return false.

	Keyword arguments:
	nti -- Integer value for Intelligence (Required)
	"""
	if typeof(nti) == TYPE_INT:
		if nti > 0:
			PAIntelligence = nti
			return PAIntelligence
		else:
			return false
	else:
		return false

func get_intelligence():
	"""
	Returns the points allocated to Intelligence
	"""
	return PAIntelligence

func set_perception(per):
	"""
	Sets the points allocated to Perception. If not an integer, or is set
	to zero, return false.

	Keyword arguments:
	per -- Integer value for Perception (Required)
	"""
	if typeof(per) == TYPE_INT:
		if per > 0:
			PAPerception = per
			return PAPerception
		else:
			return false
	else:
		return false

func get_perception():
	"""
	Returns the points allocated to Perception
	"""
	return PAPerception

func set_providence(pro):
	"""
	Sets the points allocated to Providence. If not an integer, or is set
	to zero, return false.

	Keyword arguments:
	pro -- Integer value for Providence (Required)
	"""
	if typeof(pro) == TYPE_INT:
		if pro > 0:
			PAProvidence = pro
			return PAProvidence
		else:
			return false
	else:
		return false

func get_providence():
	"""
	Returns the points allocated to Providence
	"""
	return PAProvidence

# ----
# Derived Statistics Modifying Methods
# ----

# Hit Points
func set_hit_points_creation(Con, Srn):
	"""
	Assign initial hit points on character creation.
	"""
	var HP = (Con * 15) + floor((1.5 * Srn))
	return HP

func set_hit_points_levelup(Con):
	"""
	TODO: Marked for removal (I think)
	Append additional Hit Points on character Level Up
	"""
	var HP = DSMaxHitPoints + (((randi()%6+1) / 2) + 5)
	return HP

# Ability Points
func set_ability_points_creation(Int, Per):
	"""
	Assign Ability Points on Player Creation.
	"""
	DSMaxAbilityPoints = (4 * Int) + floor((1.5 * Per))
	StatusAbilityPoints = DSMaxAbilityPoints

func set_ability_points_levelup(Int):
	"""
	Append additional ability points on character Level Up.
	TODO Marked for Removal (or Refactor into Character.gd)
	"""
	DSMaxAbilityPoints = DSMaxAbilityPoints + (Int * (randi()%6+1))
	StatusAbilityPoints = DSMaxAbilityPoints

func get_current_ability_points():
	"""
	TODO Remove (Moved to Character.gd)
	"""
	return StatusAbilityPoints

func get_max_ability_points():
	"""
	TODO Remove (Moved to Character.gd)
	"""
	return DSMaxAbilityPoints

# Attack Power
func set_attack_power_creation(Str):
	"""
	Sets the Attack Power for the Character during the creation phase.
	The Strength attribute is required for this to execute. If not
	an integer or is zero, returns false.

	Keyword arguments:
	Str -- Integer representation of strength. (Required)
	"""
	if typeof(Str) == TYPE_INT:
		if Str > 0:
			DSAttackPower = floor(Strength * 2.5)
			return DSAttackPower
		else:
			return false
	else:
		return false

func set_attack_power_levelup(AtkPts = null):
	"""
	Increases the attack points in place for the Character based on the
	formula in the docs. If AtkPts is not set, it attempts to pull it
	from the Object attribute. If either the Argument or Object attribute
	are zero or not an integer, the method retuns false.

	Keyword arguments:
	AtkPts -- Integer representation of Attack Points. Defaults to Nil.
	"""
	var RandIncrementDie = DiceObj.new()
	# var Results = BirthModifierDie.roll_the_dice(3, 20);

	if typeof(AtkPts) == TYPE_NIL:
		CalcAtkPts = DSAttackPower
	elif typeof(AtkPts) == TYPE_INT:
		if AtkPts > 0:
			CalcAtkPts = AtkPts
			DSAttackPower = CalcAtkPts + (.5 * floor(RandIncrementDie.roll_the_dice(D20_MIN, D20_MAX)))
			return DSAttackPower
		else:
			return false
	else:
		return false

func get_attack_power():
	"""
	Returns the attack power for the assigned Character.
	"""
	return DSAttackPower

# Defense Power
func set_defense_power_creation(Str, Con):
	"""
	Sets the Defense Power on Character Creation. The Strength and
	Constitutions attributes are required to set this attribute. If not an
	integer, or not greater than zero, the method returns false.

	Keyword attributes:
	Str -- Integer representation of strength. (Required).
	Con -- Integer representation of Constitution (Required).
	"""
	if (typeof(Str) == TYPE_INT) and (typeof(Con) == TYPE_INT):
		if (Str > 0) && (Con > 0):
			DSDefensePower = Con * floor(.5 * Str)
			return DSDefensePower
		else:
			return false
	else:
		return false

func set_defense_power_levelup(Str, ExistingDefPwr):
	"""
	Increases the Defense Power on Character Creation based on the outlined
	formulae in the Design Bible. Requires the Strength and Existing Power
	be passed as arguments. If they aren't integers, or are zero, the
	method returns false.

	Keyword arguments:
	Str -- Integer representation of strength. (Required).
	ExistingDefPwr -- Integer representation of Existing Defense Power.
	(Required)
	"""
	if (typeof(Str) == TYPE_INT) and (typeof(ExistingDefPwr) == TYPE_INT):
		if (Str > 0) and (ExistingDefPwr > 0):
			var DefPwrDelta = DiceObj.new()
			DefPwrMax = DefPwrDelta.roll_the_dice(1, (Str^2))
			DSDefensePower = ExistingDefPwr + floor(DefPwrMax)
			return DSDefensePower
		else:
			return false
	else:
		return false

func get_defense_power():
	"""
	Get the defensive power for the Character
	"""
	return DSDefensePower

# Ability Power
func set_ability_power_creation(Int, Pro):
	"""
	Sets the Character's ability power on creation. To do this, the
	Intelligence and Providence must be passed as non-zero Integers
	or else the method will return false.

	Keyword arguments:
	Int - Integer representation of Intelligence (Required)
	Pro - Integer representation of Providence (Required)
	"""
	if (typeof(Int) == TYPE_INT) and (typeof(Pro) == TYPE_INT):
		if (Int > 0) and (Pro > 0):
			DSAbilityPower = Int + (.5 * floor(Pro * 1.5))
			return DSAbilityPower
		else:
			return false
	else:
		return false;

func set_ability_power_levelup(ExistingAblPwr):
	"""
	Increases the ability power using the formulae outlined in the
	Design Bible. Requires that the Existing Ability Power be passed
	to it as a non-zero integer, or it will return false.

	Keyword arguments:
	ExistingAblPwr -- Integer representing the Ability Power (Required)
	"""
	if typeof(ExistingAblPwr) == TYPE_INT:
		if ExistingAblPwr > 0:
			var DiceRollObj = DiceObj.new()
			AblPwrDelta = DiceRollObj.roll_the_dice(D20_MIN, D20_MAX)
			DSAbilityPower = ExistingAblPwr + floor(.5 * AblPwrDelta)
			return DSAbilityPower
		else:
			return false
	else:
		return false

func get_ability_power():
	"""
	Returns the ability power for the Character.
	"""
	return DSAbilityPower

# Effect Resistance
func set_effect_resistance(Const, Str):
	"""
	Sets the initial Effect Resistance for a character on Creation.

	Keyword arguments:
	Const -- Integer representing Consitution. (Required)
	Str -- Integer representing Strength. (Required)
	"""
	if typeof(Const) != TYPE_INT:
		return false

	if typeof(Str) != TYPE_INT:
		return false

	if Const < 0:
		return false

	if Str < 0:
		return false

	DSEffectRes = Const * floor(((1/3) * Str))
	return DSEffectRes

func set_effect_resistance_levelup(Strength):
	"""
	Increments the Effect Resistance when the player levels up.

	Keyword arguments:
	Strength -- Integer representing the character\'s strength. (Required)
	"""
	if typeof(Strength) != TYPE_INT:
		return false

	if Strength < 0:
		return false

	var MaxStrength = Strength^2
	var DiceRollObj = DiceObj.new()
	MaxStrVal = DiceRollObj.roll_the_dice(1, MaxStrength)

	DSEffectRes = DSEffectRes + floor(MaxStrVal)
	return DSEffectRes

func get_effect_resistance():
	"""
	Returns the numeric value for the Effect Resistance.
	"""
	return DSEffectRes

# Inventory Capactiy
func set_inventory_capacity(Str):
	"""
	Sets the Inventory Capacity for the Character. Requires the Strength
	as a non-zero, non-negative Integer, or else it returns false.

	Keyword arguments:
	Str -- Measure of the Character's strength. (Required)
	"""
	if typeof(Str) == TYPE_INT:
		if Str > 0:
			DSInventoryCapacity = Str * INVENTORY_MULTI
			DSCurrentInventoryUsage = 0
			return DSInventoryCapacity
		else:
			return false
	else:
		return false

func change_inventory_capacity(inc, dec, delta, CurrentInvCap):
	"""
	Based on whatever is passed, either increases or decrease the
	current measure of inventory capacity based on the passed Delta,
	which must be a non-negative, non-zero Integer.

	Increment or Decrement, both which default to false, cannot be left as
	false or else the method will return false. One must be set to true to
	indicate expected behavior. Similarly, if both are true, the method will
	return false.

	The Current Inventory Capacity must be passed as well, as a
	non-negative, non-zero Integer. Or else, it will return false.

	If the new change to inventory goes below or equals zero, the method
	will return a string 'NegativeCapacityError' and if it goes above the
	max inventory it will return 'ExceedsCapacityError'. Otherwise, it
	will return the new Inventory Capacity.

	Keyword arguments:
	inc -- Boolean argument to process change as an increment. (Required)
	dec -- Boolean argument to process change as a decrement. (Required)
	delta -- Integer representing value to add or remove from
	Inventory Size. (Required)
	CurrentInvCap -- Integer represeting value of the inventory before
	altering. (Required)
	"""
	if (typeof(inc) == TYPE_BOOL) and (typeof(dec) == TYPE_BOOL):
		if ((inc == true) and (dec == true)) or ((inc == false) and (dec == false)):
			return false

	if typeof(delta) != TYPE_INT and delta <= 0:
		return false

	if typeof(CurrentInvCap) != TYPE_INT and CurrentInvCap <= 0:
		return false

	if (inc == true):
		NewInvUsage = CurrentInvCap + delta

		if(NewInvUsage > DSInventoryCapacity):
			return "ExceedsCapacityError"
		elif(NewInvUsage <= 0):
			return "NegativeCapacityError"
		else:
			DSCurrentInventoryUsage = NewInvUsage
			return DSCurrentInventoryUsage
	elif (dec == true):
		NewInvUsage = CurrentInvCap - delta

		if(NewInvUsage > DSInventoryCapacity):
			return "ExceedsCapacityError"
		elif(NewInvUsage <= 0):
			return "NegativeCapacityError"
		else:
			DSCurrentInventoryUsage = NewInvUsage
			return DSCurrentInventoryUsage

func get_max_inventory_capacity():
	"""
	Gets the maximum inventory capacity.
	"""
	return DSInventoryCapacity

func get_current_inventory_capacity():
	"""
	Gets the current inventory capacity.
	"""
	return DSCurrentInventoryUsage

# Agility
func set_agility_creation(Srn, Con):
	"""
	Set the starting agility value. Requires the Strength and
	Constitution to be set in place, or else it will return false

	Keyword arguments:
	Srn -- Character's Strength. (Required)
	Con -- Character's Constitution (Required)
	"""
	if (typeof(Srn) == TYPE_INT) and (typeOf(Con) == TYPE_INT):
		if (Srn > 0) and (Con > 0):
			DSAgility = floor((1/2) * Srn) + floor((1/3) * Con)
			return DSAgility
		else:
			return false
	else:
		return false

func set_agility_levelup(DSAgility):
	"""
	Increases the Agility attribute at Level up.
	"""
	DSAgility = DSAgility + (floor(randf()*.5+1) * DSAgility)
	return DSAgility

func get_agility():
	"""
	Returns the Agility Attribute for the Character.
	"""
	return DSAgility

# Critical Thinking
func set_critical_thinking(Int, Pro):
	"""
	Set the starting Critical Thinking value. Requires the Intelligence
	and Providence to be set, or else it will return false

	Keyword arguments:
	Int -- Character's Intelligence. (Required)
	Pro -- Character's Providence (Required)
	"""

	# TODO Sanity Check
	if (typeof(Int) == TYPE_INT) and (typeof(Pro) == TYPE_INT):
		if (Int > 0) && (Pro > 0):
			# Calculate the Providence Caveat
			randomize();
			var caveatSeed = randi()%4097+1
			var ProvidenceMulti = 0;

			if (caveatSeed >= 1) and (caveatSeed <= Pro):
				ProvidenceMulti = floor(Int / 2);
			else:
				ProvidenceMulti = 0

			DSCriticalThinking = (Int * 2) + ProvidenceMulti
			return DSCriticalThinking
		else:
			return false
	else:
		return false

func get_critical_thinking():
	"""
	Returns the Character's Critical Thinking.
	"""
	return DSCriticalThinking

# Economics
func set_economics(nti):
	"""
	Assigns Economic Points on Character Creation. Requires the
	Intelligence Attribute to be set. If not set or is zero,
	the function returns false.

	Keyword arguments:
	nti -- Character's Intelligence. (Required)
	"""

	if typeof(nti) == TYPE_INT:
		if nti > 0:
			var coin = CoinFlipObj.new()
			var modulo_operator

			if(coin.flip_coin() == "H"):
				modulo_operator = 1/2;
			else:
				modulo_operator = 1/3;

			DSEconomics = modulo_operator * (nti * 4)
			return DSEconomics
		else:
			return false
	else:
		return false

func get_economics():
	"""
	Returns the Character's understanding of Economics.
	"""
	return DSEconomics

# Communication
func set_communication_creation(Int, Per, Pro):
	"""
	Assigns Communication points on Character Creation. Requires the
	Intelligence, Perception, and Providence attributes to be set. If
	not set or is zero, the function returns false.

	Keyword arguments:
	Int -- Character's Intelligence (Required)
	Per -- Character's Perception (Required)
	Pro -- Character's Providence (Required)
	"""
	if (typeof(Int) == TYPE_INT) and (typeof(Per) == TYPE_INT) and (typeof(Pro) == TYPE_INT):
		if (Int > 0) and (Per > 0) and (Pro > 0):
			var ProvMultiplier = randi()%11+1
			DSCommunication = Int * floor((1/3) * (Per * (Pro * ProvMultiplier)))
			return DSCommunication
		else:
			return false
	else:
		return false

func set_communication_levelup():
	"""
	Increase the Character's understanding of Communication. This assumes
	that the the Intelligence and Perception are set in the Object
	instance.

	TODO: Maybe move to arguments.
	"""
	DSCommunication = floor((1/3) * (PAIntelligence + PAPerception))
	return DSCommunication;

func get_communication():
	"""
	Returns the value of the Communication attribute.
	"""
	return DSCommunication

# Crafting
func set_crafting_creation(Int, Pro):
	"""
	Sets the crafting value for the Character on creation. This value remains
	unchanged throughout the game. All values must be non-zero, non-negative
	integers or else the method returns false.

	Keyword arguments:
	Int -- The Character's Intelligence. (Required)
	Pro -- The Character's Providence. (Required)
	"""
	if (typeof(Int) == TYPE_INT) and (typeof(Pro) == TYPE_INT):
		if (Int > 0) and (Pro > 0):
			var DiceRollObj = DiceObj.new()
			CraftingRandomAdd = DiceRollObj.roll_the_dice(D20_MIN, Pro)
			DSFabrication = (Int * 3) + floor(CraftingRandomAdd)
			return DSFabrication
		else:
			return false
	else:
		return false

func get_crafting():
	"""
	Returns Crafting Score for the Character.
	"""
	return DSFabrication

# ----
# Skills Modifying Methods
# ----
# TODO deferreds to update other attributes
