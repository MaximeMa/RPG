extends Node

var pickable = false

func _ready():
	pass

func _process(_delta):
	if pickable == true:
		if Input.is_action_just_pressed("ui_accept"):
			Global.emit_signal("swordPick")
			Global.emit_signal("swordPick", 1)

func _on_Area2D_body_entered(body: KinematicBody2D):
	pickable = true

func _on_Area2D_body_exited(body: KinematicBody2D):
	pickable = false
