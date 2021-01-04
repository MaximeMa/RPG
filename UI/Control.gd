extends Control

onready var animated = $AnimatedSprite

func _ready():
	animated.frame = 0
	
func playing_animation():
	animated.play("oui")
	
