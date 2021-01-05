extends Control

export(int) var numberOfFrame = 8

onready var animated = $AnimatedSprite
onready var slot1 = $"Item/Slot 1"
onready var slot2 = $"Item/Slot 2"
onready var slot3 = $"Item/Slot 3"
onready var slot4 = $"Item/Slot 4"
onready var slot5 = $"Item/Slot 5"
onready var slot6 = $"Item/Slot 6"

var Slot1 = 8
var Slot2 = 8
var Slot3 = 8
var Slot4 = 8
var Slot5 = 8
var Slot6 = 8


func _on_ready():
	pass

func _process(_delta):
	if Input.is_action_just_pressed("Inventory"):
		check_slots()

func playing_animation():
	animated.play("oui")

func check_slots():
	if slot1.frame < numberOfFrame:
		Slot1 = slot1.frame
		if slot2.frame < numberOfFrame:
			Slot2 = slot2
			if slot3.frame < numberOfFrame:
				Slot3 = slot3
				if slot4.frame < numberOfFrame:
					Slot4 = slot4
					if slot5.frame < numberOfFrame:
						Slot5 = slot5
						if slot6.frame < numberOfFrame:
							Slot6 = slot6
							print("l'inventaire est full")
						else:
							print("slot 6 libre")
					else:
						print("slot 5-6 libre")
				else:
					print("slot 4-6 libre")
			else:
				print("slot 3-6 libre")
		else:
			print("slot 2-6 libre")
	else:
		print("slot 1-6 libre")

func _add_item(item):
	pass
