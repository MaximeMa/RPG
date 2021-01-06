extends Node2D

var item = 1
var picked = false
var connect = true
var domiral = true

func _process(_delta):
	if connect == true:
# warning-ignore:return_value_discarded
		Global.connect("swordPick",self, "_picked")
		connect = false
	if domiral == true:	
		if picked == true:
			remove_child($"Item")
			domiral = false
func _picked():
	picked = true
