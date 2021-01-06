extends KinematicBody2D

enum {
	IDLE,
	WANDER,
	CHASE
}

export var ACCELERATION = 300
export var MAX_SPEED = 50
export var FRICTION = 200
export var TARGET_RANGE = 2

const EnemyDeathEffect = preload("res://src/Effects/EnemyDeathEffect.tscn")

var velocity = Vector2.ZERO
var knockback = Vector2.ZERO
var state = IDLE

onready var sprite = $BatAnimatedSprite
onready var stats = $Stats
onready var playerDetecion = $PlayerDetection
onready var hurtBox = $HurtBox
onready var softCollision = $SoftCollision
onready var wanderController = $WanderController

func _ready():
	state = if_new_state([IDLE, WANDER])

func _physics_process(delta):
	knockback = move_and_slide(knockback)
	knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			seek_Player()
			if wanderController.get_time_left() == 0:
				state = if_new_state([IDLE, WANDER])
				wanderController.start_wander_timer(rand_range(1, 3))
		WANDER:
			seek_Player()
			if wanderController.get_time_left() == 0:
				state = if_new_state([IDLE, WANDER])
				wanderController.start_wander_timer(rand_range(1, 3))
			accelerate_toward_position((wanderController.targetPosition), delta)
			
			
			if global_position.distance_to(wanderController.targetPosition) <= TARGET_RANGE :
				state = if_new_state([IDLE, WANDER])
		CHASE:
			var player = playerDetecion.player
			if player != null:
				accelerate_toward_position((player.global_position), delta)

	if softCollision.is_colliding():
		velocity += softCollision.get_push_vector() * delta * 100
	velocity = move_and_slide(velocity)

func accelerate_toward_position(positionPoint, delta):
	var direction = global_position.direction_to(positionPoint)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	sprite.flip_h = velocity.x < 0

func _on_HurtBox_area_entered(area):
	knockback= area.knockbackVector * 120
	stats.health -= area.damage
	hurtBox.create_hit_effect()

func seek_Player():
	if playerDetecion.can_see_player():
		state = CHASE

func _on_Stats_no_health():
	queue_free()
	var enemyDeathEffect = EnemyDeathEffect.instance()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position

func if_new_state(stateList):
	stateList.shuffle()
	return stateList.pop_front()

