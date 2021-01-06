extends Node2D


export(bool) var random = false
export(Script) var game_save_class

var connect = true
var saveVars = ["playerPos", "maxHealth", "health", "ItemSlot1", "ItemSlot2", "ItemSlot3", "ItemSlot4", "ItemSlot5", "ItemSlot6"]
func _ready():
	if not _load_game():
		pass
	if random == true:
		randomize()

func _process(_delta):
	if connect == true:
		Global.connect("save", self, "_save_game")
		Global.connect("loadSave", self, "_load_game")
		connect = false

func _save_game():
	var newSave = game_save_class.new()
	newSave.playerPos = $"YSort/Player".position
	newSave.maxHealth = PlayerStats.maxHealth
	newSave.health    = PlayerStats.health
	newSave.ItemSlot1 = $"YSort/Player/YSort/Inventory".slot1.frame
	newSave.ItemSlot2 = $"YSort/Player/YSort/Inventory".slot2.frame
	newSave.ItemSlot3 = $"YSort/Player/YSort/Inventory".slot3.frame
	newSave.ItemSlot4 = $"YSort/Player/YSort/Inventory".slot4.frame
	newSave.ItemSlot5 = $"YSort/Player/YSort/Inventory".slot5.frame
	newSave.ItemSlot6 = $"YSort/Player/YSort/Inventory".slot6.frame
	
	var dir = Directory.new()
	if not  dir.dir_exists("user://saves/"):
		dir.make_dir_recursive("user://saves/")

	ResourceSaver.save("user://saves/Save_01.tres", newSave)

func _load_game():
	var dir = Directory.new()
	if not dir.file_exists("user://saves/Save_01.tres"):
		return false
		
	var gameSave = load("user://saves/Save_01.tres")
	if not _verify_save(gameSave):
		return false
		
	$"YSort/Player".position = gameSave.playerPos
	PlayerStats.maxHealth = gameSave.maxHealth
	PlayerStats.health = gameSave.health
	$"YSort/Player/YSort/Inventory".slot1.frame = gameSave.ItemSlot1
	$"YSort/Player/YSort/Inventory".slot2.frame = gameSave.ItemSlot2
	$"YSort/Player/YSort/Inventory".slot3.frame = gameSave.ItemSlot3
	$"YSort/Player/YSort/Inventory".slot4.frame = gameSave.ItemSlot4
	$"YSort/Player/YSort/Inventory".slot5.frame = gameSave.ItemSlot5
	$"YSort/Player/YSort/Inventory".slot6.frame = gameSave.ItemSlot6
	
	return true
	

func _verify_save(GameSave):
	for v in saveVars:
		if GameSave.get(v) == null:
			return false
	return true
	
	
 
