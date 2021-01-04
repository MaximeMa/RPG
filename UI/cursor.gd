extends Sprite

var x = -95
var y = -32

onready var animated = $"../AnimatedSprite"

func _ready():
	hide()

func _on_AnimatedSprite_animation_finished():
	show()
	
func _process(_delta):
	if animated.frame < 8:
		hide()
	else:
		show()
	if animated.frame == 9:
		if Input.is_action_just_pressed("ui_right"):
			x = x + 95
			position = Vector2(x, y)
		if Input.is_action_just_pressed("ui_left"):
			x = x - 95
			position = Vector2(x, y)
		if Input.is_action_just_pressed("ui_down"):
			y = y + 64
			position = Vector2(x, y)
		if Input.is_action_just_pressed("ui_up"):
			y = y - 64
			position = Vector2(x, y)
		if x > 95:
			position = Vector2(95, y)
			x = x - 95
		if x < -95:
			position = Vector2(-95, y)
			x = x + 95
		if y < -32:
			position = Vector2(x, -32)
			y = y + 64
		if y > 32:
			position = Vector2(x, 32)
			y = y - 64
