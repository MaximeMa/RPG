extends Node

export(int) var maxHealth = 1 setget set_max_health
var health = maxHealth setget set_health
var connect = true

signal no_health
signal health_changed(value)
signal max_health_changed(value)

func _process(_delta):
	if health > maxHealth:
		set_health(maxHealth)
	if connect == true:
		Global.connect("drinkRedPotion", self, "_heal")
		connect = false

func set_max_health(value):
	maxHealth = value
	self.health = min(health, maxHealth)
	emit_signal("max_health_changed", maxHealth)

func set_health(value):
	health = value
	emit_signal("health_changed", health)
	if health <= 0:
		emit_signal("no_health")

func _ready():
	self.health = maxHealth

func _heal():
	health = health + 4
	emit_signal("health_changed", health)
