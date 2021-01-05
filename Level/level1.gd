extends Node2D

export(bool) var random = false
export(bool) var isPaused = false

func _ready():
	if random == true:
		randomize()


