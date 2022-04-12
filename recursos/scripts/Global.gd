extends Node

var nivel
var player
var fade
var UI_player
var monedasActuales = 0
var camara
var puerta
var musica_de_fondo

func _ready():
	musica_de_fondo = AudioStreamPlayer.new()
	add_child(musica_de_fondo)
	musica_de_fondo.stream = load("res://recursos/musica/musica_de_fondo.ogg")
	musica_de_fondo.play()

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
		if Global.UI_player:
			Global.UI_player.refrescarUI()

