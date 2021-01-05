extends Node2D

export(int) var wanderRange = 32

onready var startPosition = global_position
onready var targetPosition = global_position
onready var timer = $Timer

func _ready():
	updtate_target_positions()

func updtate_target_positions():
	var target_vector = Vector2(rand_range(-wanderRange, wanderRange), rand_range(-wanderRange, -wanderRange)) 
	targetPosition = startPosition + target_vector

func _on_Timer_timeout():
	updtate_target_positions()

func get_time_left():
	return timer.time_left

func start_wander_timer(duration):
	timer.start(duration)
