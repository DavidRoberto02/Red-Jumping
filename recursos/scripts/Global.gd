extends Node

var player
var UI_player
var monedas = 0

func _ready():
	pass

func _process(delta):
	pass

func get_screen_size():
	var x = ProjectSettings.get("display/window/size/width")
	var y = ProjectSettings.get("display/window/size/height")
	return Vector2(x, y)



