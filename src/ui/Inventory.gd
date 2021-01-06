extends Control

export(int) var numberOfFrame = 8

onready var animated = $AnimatedSprite
onready var slot1 = $"Item/Slot 1"
onready var slot2 = $"Item/Slot 2"
onready var slot3 = $"Item/Slot 3"
onready var slot4 = $"Item/Slot 4"
onready var slot5 = $"Item/Slot 5"
onready var slot6 = $"Item/Slot 6"
onready var cursor =$"cursor"

var connect = true
var Slot1 = 8 
var Slot2 = 8 
var Slot3 = 8 
var Slot4 = 8 
var Slot5 = 8 
var Slot6 = 8 
var Slot1Free = false
var Slot2Free = false
var Slot3Free = false
var Slot4Free = false
var Slot5Free = false
var Slot6Free = false
var inventoryFull = false
var haveSword = false
var currentCursor = 8
var currentItem = 0

func _on_ready():
	pass

func _process(_delta):
	if Input.is_action_just_pressed("Inventory"):
		print(Slot1)
	if connect == true:
# warning-ignore:return_value_discarded
		Global.connect("pick", self, "_add_item")
		Global.connect("swordPick", self,"_add_item")
		connect = false
	_check_slots()
	if slot1.frame == 1 or slot2.frame == 1or slot3.frame == 1 or slot4.frame == 1 or slot5.frame == 1 or slot6.frame == 1:
		haveSword = true
	if haveSword == true:
		Global.emit_signal("haveSword", true)
	else:
		Global.emit_signal("haveSword", false)
	if animated.frame == 9:
		_check_cursor()
		if Input.is_action_just_pressed("ui_accept"):
			item_action()

func _playing_animation():
	animated.play("oui")

func _check_slots():
	if slot1.frame < numberOfFrame:
		match slot1.frame:
			1:
				Slot1 = 1
			2: 
				Slot1 = 2
			3: 
				Slot1 = 3
			4:
				Slot1 = 4
			5:
				Slot1 = 5
			6:
				Slot1 = 6
			7:
				Slot1 = 7
			8:
				Slot1 = 8
				Slot1Free = true
		if slot2.frame < numberOfFrame:
			match slot2.frame:
				1:
					Slot2 = 1
				2: 
					Slot2 = 2
				3: 
					Slot2 = 3
				4:
					Slot2 = 4
				5:
					Slot2 = 5
				6:
					Slot2 = 6
				7:
					Slot2 = 7
				8:
					Slot2 = 8
					Slot2Free = true
			if slot3.frame < numberOfFrame:
				match slot3.frame:
					1:
						Slot3 = 1
					2: 
						Slot3 = 2
					3: 
						Slot3 = 3
					4:
						Slot3 = 4
					5:
						Slot3 = 5
					6:
						Slot3 = 6
					7:
						Slot3 = 7
					8:
						Slot3 = 8
						Slot3Free = true
				if slot4.frame < numberOfFrame:
					match slot4.frame:
						1:
							Slot4 = 1
						2: 
							Slot4 = 2
						3: 
							Slot4 = 3
						4:
							Slot4 = 4
						5:
							Slot4 = 5
						6:
							Slot4 = 6
						7:
							Slot4 = 7
						8:
							Slot4 = 8
							Slot4Free = true
					if slot5.frame < numberOfFrame:
						match slot5.frame:
							1:
								Slot5 = 1
							2: 
								Slot5 = 2
							3: 
								Slot5 = 3
							4:
								Slot5 = 4
							5:
								Slot5 = 5
							6:
								Slot5 = 6
							7:
								Slot5 = 7
							8:
								Slot5 = 8
								Slot5Free = true
						if slot6.frame < numberOfFrame:
							match slot6.frame:
								1:
									Slot6 = 1
								2: 
									Slot6 = 2
								3: 
									Slot6 = 3
								4:
									Slot6 = 4
								5:
									Slot6 = 5
								6:
									Slot6 = 6
								7:
									Slot6 = 7
								8:
									Slot6 = 8
									Slot6Free = true
							inventoryFull = true
						else:
							Slot6Free = true
					else:
						Slot5Free = true
				else:
					Slot4Free = true
			else:
				Slot3Free = true
		else:
			Slot2Free = true
	else:
		Slot1Free = true

func _add_item(item):
	if Slot1Free == true:
		slot1.frame = item
		Slot1Free = false
	else:
		if Slot2Free == true:
			slot2.frame = item
			Slot2Free = false
		else:
			if Slot3Free == true:
				slot3.frame = item
				Slot3Free = false
			else:
				if Slot4Free == true:
					slot4.frame = item
					Slot4Free = false
				else:
					if Slot5Free == true:
						slot5.frame = item
						Slot5Free = false
					else:
						if Slot6Free == true:
							slot6.frame = item
							Slot6Free = false
						else:
							inventoryFull = true

func _check_cursor():
	if cursor.position == slot1.position:
		currentCursor = slot1
		currentItem = slot1.frame
	else:
		if cursor.position == slot2.position:
			currentCursor = slot2
			currentItem = slot2.frame
		else:
			if cursor.position == slot3.position:
				currentCursor = slot3
				currentItem = slot3.frame
			else:
				if cursor.position == slot4.position:
					currentCursor = slot4
					currentItem = slot4.frame
				else:
					if cursor.position == slot5.position:
						currentCursor = slot5
						currentItem = slot5.frame
					else:
						if cursor.position == slot6.position:
							currentCursor = slot6
							currentItem = slot6.frame

func item_action():
	match currentItem:
		1:
			pass
		2:
			Global.emit_signal("drinkRedPotion")
			currentCursor.frame = 8



