extends Area2D

const HitEffect = preload("res://Asset/Effects/HitEffect.tscn")

var invicible = false setget set_invicible

onready var timer = $Timer

signal invicibility_started
signal invicibility_ended

func set_invicible(value):
	invicible = value
	if invicible == true:
		emit_signal("invicibility_started")
	else:
		emit_signal("invicibility_ended")

func create_hit_effect():
	var effect = HitEffect.instance()
	var main = get_tree().current_scene
	main.add_child(effect)
	effect.global_position = global_position 

func _on_Timer_timeout():
	self.invicible = false

func start_invicibility(duration):
	timer.start(duration)
	self.invicible = true

func _on_HurtBox_invicibility_started():
	set_deferred("monitorable", false)

func _on_HurtBox_invicibility_ended():
	monitorable = true
