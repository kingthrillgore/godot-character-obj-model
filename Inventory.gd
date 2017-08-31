
# extends Node
extends Node

# Inventory Variables
var InvMaxCapacity = 0
var InvCurrentUse = 0
var InvItems = []
var KeyInvItems = []
var IsInvOverencumbered = false #TOOD Move to Character
var CapacityOverencumbered = 0 #TODO Move to Character

const VALID_ITEM_ATTRS = ['GUID', 'ParentClass', 'Purpose', 'ItemClass', 'ID',
	'PrimaryRole', 'SecondaryRole', "TertiaryRole"
	'IsStackable', 'MaxStackSize', "InvSize", "Name", "Description",
	"FreeTags", "ResellValue", "IsKeyItem"]
const INV_MULTIPLIER = 7
const MAX_STACK_SIZE = 20

# Inner Classes
# TODO

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func CreateInv(Str):
	'''
	Preps an Inventory Object for usage.

	Keyword Arguments:
	Str -- Integer representation of Strength. (Required)
	'''
	if typeof(Str) != TYPE_INT:
		return false

	if Str < 0:
		return false

	InvMaxCapacity = INV_MULTIPLIER * Str
	return InvMaxCapacity

func AddItemToInv(ItemObj):
	'''
	Adds a defined item to the inventory. Items are defined as dictionary items
	taking upon the following format.

	{
		"ParentClass": Equippable",
		"Purpose": "Equippable",
		"ItemClass": "ItemWeapon",
		"GUID": "0000-0000-0000-0000",
		"ID": "YNPShortSword",
		"PrimaryRole": "Weapon",
		"IsStackable": false,
		"InvSize": "10",
		"Name": "National Police Shortsword",
		"Description": "The standard issue short-sword, commonly used for
			ceremonial practices.",
		"FreeTags": ["weapon", "sword"],
		"ResellValue": 10.00,
		"IsKeyItem": false
	}

	The dictionary is checked for all of the above attributes.

	All attributes excluding ItemFreeTags, MaxStackSize, TertiaryRole, and
	ItemResellValue are required

	If the item is not sent or the dictionary is empty, the method will
	return "ItemNotSet".

	If the item is not a Dictionary, the method will return "ItemNotDict".

	If a required attribute is missing, it is Rejected from the Inventory
	with the string error "MissingDictionaryAttributes" returned.

	If an attribute that does not match the potentials above is found, the item is
	rejected from the Inventory and the string error "MalformedDictionaryAttr" is
	returned.

	If the Item Inventory Size exceeds the MaxCapacity, the item is rejected
	and the method will return error "ItemLargerThanMaxInvSize". This is not a
	factor if IsKeyItem is set to true, as Key Items are persistent and do not
	affect inventory size.

	If the item will run the Inventory Capacity greater than the current
	maximum capacity, the item is rejected and the method will return error
	"ItemWillForceOvercapacity".

	If the item is missing any defined attribute, the item will be rejected and
	state the error in a dictionary:

	{
		"ItemRejected": true
		"AttributeRejected": {ATTRIBUTE_KEY}
		"ReasonForRejection": {REASON_FOR_REJECTION}
	}

	The complete list of rejections can be seen in the comments below (these will
	be pulled into the docs in the future).

	If the item is valid, the item is added and the method returns the following
	dictionary:

	TODO

	Keyword Attributes:
	ItemObj -- Dictionary entry with the Item in question. (Required)
	'''

	# Check validity based on the objects above, and with what is defined in the
	# specification
	if typeof(ItemObj) != TYPE_DICTIONARY:
		return "ItemNotDict"

	if typeof(ItemObj) == TYPE_NIL:
		return "ItemNotSet"

	if ItemObj.empty():
		return "ItemNotSet"

	var passesDictValidation = CheckItemEntry(ItemObj)
	if passesDictValidation != TYPE_NIL:
		return passesDictValidation

	if ItemObj.InvSize > InvMaxCapacity and ItemObj.IsKeyItem == false:
		return "ItemLargerThanMaxInvSize"

	if (InvCurrentInvUse + ItemObj.InvSize) > and ItemObj.IsKeyItem == false:
		return "ItemWillForceOvercapacity"

	# Check validity of items in the Dictionary

	# Add Item to Dictionary
	# TODO Adjust Inventory Size
	InvItems.push_back(ItemObj)

func CheckItemEntry(ItemObj):
	"""
	Delegate call for AddItemToInv(). This call handles the verification of
	the Item dictionary item.
	"""
	for k in VALID_ITEM_ATTRS:
		if ItemObj.has(k) == false:
			return "MissingDictionaryAttributes"

# Set/Increment Inventory Size Methods
func SetInventoryMax(InvMax):
	'''
	Sets the Maximum Inventory as passed in InvMax. If InvMax is zero, or
	negative, or not an integer, it will return false.

	If successful, the method returns the newly set Inventory Max.

	Keywors arguments
	InvMax -- Integer that represents the new Inventory Max Size. (Required)
	'''
	if typeof(InvMax) != TYPE_INT:
		return false

	if InvMax <= 0:
		return false

	InvMaxCapacity = InvMax
	return InvMaxCapacity

func IncrementInventoryMax(Delta):
	'''
	Increases the Inventory Size by the aforementioned delta passed in a keyword
	argument. Delta must be a positive, non-zero integer or else the method
	returns false. If successful, the new Inventory Size will be returned.

	Keyword arguments:
	Delta -- Integer size for which to increase the Inventory.
	'''
	if typeof(Delta) != TYPE_INT:
		return false

	if Delta <= 0:
		return false

	InvMaxCapacity = InvMaxCapacity + Delta
	return InvMaxCapacity

function DecrementInventoryMax(Delta):
	'''
	Decreases the Inventory Size by the aforementioned delta passed in a keyword
	argument. Delta must be a positive, non-zero integer or else the method will
	return false. If successful, the new Inventory Size will be returned.

	If the Delta will cause the Max Inventory to reach zero or a negative value,
	the method will also return false.

	Keyword arguments:
	Delta -- Integer size for which to decrease the Inventory.
	'''
	if typeof(Delta) != TYPE_INT:
		return false

	if Delta <= 0:
		return false

	if (InvMaxCapacity - Delta) <= 0:
		return false

	InvMaxCapacity = InvMaxCapacity - Delta
	return InvMaxCapacity

# Get Inventory Info Methods
func GetInventoryMax():
	'''
	Returns the Maximum size of the inventory.
	'''
	return InvMaxCapacity

func GetCurrentInventorySize():
	'''
	Returns the size of the inventory being used.
	'''
	return InvCurrentUse

func GetInventoryItems():
	'''
	Returns the Dictionary for all Items currently being used by the Dictionary.
	'''
	return InvItems

func RemoveItemFromInventory(Item, ReasonForRemoval):
	'''
	Removes an item from the inventory. The item is flushed from the Inventory
	list when its key is found.

	If its not found, the method returns an error of "ItemNotFound". If the field
	Item is not defined with a valid Item Dictionary entry or pointer to a Object
	instance in memory, the method returns false.

	ReasonForRemoval is not used, and is not required. If A non-string is sent to
	it, the method returns error "InvalidTypeReasonForRemoval".

	Keyword arguments:
	Item -- Dictionary Instance of Item or a Pointer to an Object reference in
	memory space, for the item to be removed. (Required)
	ReasonForRemoval -- A string representing a one word summary for its removal.
	Currently not used.
	'''
	if typeof(Item) != TYPE_NIL:
		return false

	if (typeof(Item) != TYPE_DICTIONARY) or (typeof(Item) != TYPE_OBJECT):
		return false

	if (typeof(ReasonForRemoval) != TYPE_STRING) or
		(typeof(ReasonForRemoval) != TYPE_NIL):
			return "InvalidTypeReasonForRemoval"

	# Remove Item From Inventory
	var ItemLocation = InvItems.find(Item)

	if ItemLocation == -1:
		return "ItemNotFound"
	else:
		InvCurrentUse = InvCurrentUse - InvItems[ItemLocation].InvSize
		InvItems.erase(ItemLocation)
		return "ItemRemoved"

func StackInventoryItems(Item, ItemToAdd, MaxStackSize):
	'''
	Stacks items on top of one another, unless the size of the stack limit
	reaches the maximum.
	'''
	if typeof(Item) != TYPE_DICTIONARY or typeof(Item) != TYPE_OBJECT:
		return "InvalidItemType"

	if typeof(ItemToAdd) != TYPE_DICTIONARY or typeof(ItemToAdd) != TYPE_OBJECT:
		return "InvalidItemToAddType"

	if Item.IsStackable == false:
		return "ItemNotStackable"

	if ItemToAdd.IsStackable == false:
		return "ItemToAddNotStackable"

	#TODO Stack Consolidation Logic

func UnstackInventoryItem(Item):
	'''
	Removes one item from a stacked inventory item.
	'''
	#TODO

func BreakItemStack(Item):
	'''
	Breaks all the items from a Stack.
	'''
	#TODO

func SearchInventory(SearchType, SearchRequest):
	'''
	Searches the Inventory for a specific item(s). This method serves as a
	delegate for multiples based on the mechanism declared in SearchType. This
	method can also return zero, or null, when no results exist.

	If SearchType is not set, is a type that is not a String, or of the kind
	outlined below, the method returns "InvalidSearchType"

	The available search mechanisms part of the method and its child methods are:
		* guid
		* id
		* name
		* freetags
		* category
		* stackable
		* keyitem
		* purpose

	Keyword Arguments:
	SearchType -- The kind of Search mechanism to use. (Required)
	SearchRequest -- The actual item you are requesting. If set to nothing,
	Search will return all possible items based on the mechanism set. If set to
	an Asterisk (*), it functions s imilar to if set as blank. Partial String
	searches are not yet supported.
	'''
	# Validation
	if typeof(SearchType) == TYPE_NIL:
		return "InvalidSearchType"

	if SearchType == "guid":
		Results = SearchInvByGuid(SearchRequest)
		return Results
	elif SearchType == "id"
		Results = SearchInvById(SearchRequest)
		return Results
	elif SearchType == "freetags"
		Results = SearchInvByFreetags(SearchRequest)
		return Results
	elif SearchType == "category"
		Results = SearchInvByCategory(SearchRequest)
		return Results
	elif SearchType == "stackable"
		Results = SearchInvByStackable(SearchRequest)
		return Results
	elif SearchType == "keyitem"
		Results = SearchInvByKeyItem(SearchRequest)
		return Results
	elif SearchType == "purpose":
		Results = SearchInvByPurpose(SearchRequest)
		return Results
	else:
		return "InvalidSearchType"
