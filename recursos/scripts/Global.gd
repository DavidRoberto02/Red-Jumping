extends Node

var nivel
var player
var fade
var UI_player
var monedasActuales = 0
var camara
var puerta

func _ready():
	pass

func _process(delta):
	pass

func get_screen_size():
	var x = ProjectSettings.get("display/window/size/width")
	var y = ProjectSettings.get("display/window/size/height")
	return Vector2(x, y)

func incrementar_monedas(nuevasMonedas):
	player.monedasActuales += nuevasMonedas
	if puerta:
		puerta.refrescarPuerta()

