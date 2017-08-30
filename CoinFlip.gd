extends Node

func _ready():
	pass

func flip_coin(p = 0.5):
	"""
	Simulates a coin flip with no variance tensions. Essentially a binary random
	operation based on Godot randf() which itself us based on xorshift128.

	Returns a string representing the coin value as either Heads (H) or Tails (T)
	"""
	var coin = null
	randomize()

	if randf() < p:
		coin = 'H'
	else:
		coin = 'T'
	return coin
