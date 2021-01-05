extends AnimatedSprite

func _ready():
	connect("animation_finished", self,"_on_AnimatedSprite_animation_finished")
	play("Animate")
	frame = 0


func _on_AnimatedSprite_animation_finished():
	queue_free()

