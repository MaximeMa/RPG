extends Node2D

export(bool) var random = false

func _ready():
	if random == true:
		randomize()
