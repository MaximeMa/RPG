extends KinematicBody2D

export var ACCELERATION = 500
export var MAX_SPEED = 100
export var ROLL_SPEED = 125
export var FRICTION = 500

enum{
	MOVE,
	ROLL,
	ATTACK
}

var velocity = Vector2.ZERO
var state = MOVE
var roll_vector  = Vector2.DOWN
var stats = PlayerStats
var simultaneous_scene = preload("res://src/Level/GameOver.tscn").instance()
var inventoryState = "HIDE"
var canAttack = false
var connect = true

onready var animationPlayer = $AnimationPlayer 
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var swordHitbox = $Position2D/SwordHitBox
onready var hurtBox = $HurtBox
onready var inventory =  $"YSort/Inventory"

func _physics_process(delta):
	if connect == true:
		Global.connect("haveSword", self, "set_can_attack")
		connect = false
	match state:
		MOVE:
			move_state(delta)
		ROLL:
			roll_state(delta)
		ATTACK:
			attack_state(delta)
		
	match inventoryState:
			"HIDE":
				inventory.hide()
				get_tree().paused = false
				ACCELERATION = 500
				FRICTION = 500
				MAX_SPEED = 100
				inventory.animated.frame = 0
				
			"SHOW":
				inventory.show()
				get_tree().paused = true
				inventory._playing_animation()
				ACCELERATION = 0
				FRICTION = 999999999999999
				MAX_SPEED = 0
				velocity = move_and_slide(Vector2.ZERO)
				
				

	if Input.is_action_just_pressed("Inventory"):
		if inventoryState == "HIDE":
			inventoryState = "SHOW"
		else:
			inventoryState = "HIDE"

func _ready():
	stats.connect("no_health", self, "game_over")
	animationTree.active = true
	swordHitbox.knockbackVector = roll_vector

func move_state(delta):
	#that code permite to the player to move
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		roll_vector = input_vector
		swordHitbox.knockbackVector = input_vector
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationTree.set("parameters/Roll/blend_position", input_vector)
		animationState.travel("Run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	move()	
	
	if Input.is_action_just_pressed("Attack"):
		if canAttack == true:
			state = ATTACK
		
	if Input.is_action_just_pressed("roll"):
		state = ROLL

func roll_state(delta):
	velocity = roll_vector * ROLL_SPEED
	animationState.travel("Roll")
	move()

func attack_state(delta):
	velocity = Vector2.ZERO				
	animationState.travel("Attack")
	
func attack_animation_finished():
	velocity = velocity * 0
	state = MOVE
	
func roll_animation_finished():
	state = MOVE
	
func move():
	velocity = move_and_slide(velocity)

func _on_HurtBox_area_entered(area):
	stats.health -= 1
	hurtBox.start_invicibility(1)
	hurtBox.create_hit_effect()

func game_over():
	queue_free()
	get_tree().get_root().add_child(simultaneous_scene)
	
func set_can_attack(value):
	canAttack = value

