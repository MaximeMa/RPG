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
	if connect == true:
# warning-ignore:return_value_discarded
		Global.connect("pick", self, "_add_item")
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
		_match(slot1, Slot1, Slot1Free)
		if slot2.frame < numberOfFrame:
			_match(slot2, Slot2, Slot2Free)
			if slot3.frame < numberOfFrame:
				_match(slot3, Slot3, Slot3Free)
				if slot4.frame < numberOfFrame:
					_match(slot4, Slot4, Slot4Free)
					if slot5.frame < numberOfFrame:
						_match(slot5, Slot5, Slot5Free)
						if slot6.frame < numberOfFrame:
							_match(slot6, Slot6, Slot6Free)
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

func _match(slot, Slot, SlotFree):
	match slot.frame:
			1:
				Slot = 1
			2: 
				Slot = 2
			3: 
				Slot = 3
			4:
				Slot = 4
			5:
				Slot = 5
			6:
				Slot = 6
			7:
				Slot = 7
			8:
				Slot = 8
				SlotFree = true

func item_action():
	match currentItem:
		1:
			pass
		2:
			Global.emit_signal("drinkRedPotion")
			currentCursor.frame = 8
