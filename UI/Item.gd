extends Node2D

onready var animated = $"../AnimatedSprite"

func _process(_delta):
	if animated.frame < 8:
		hide()
	else:
		show()
