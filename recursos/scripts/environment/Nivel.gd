extends Node

export(int) var monedasParaAbrir = 0
export(String) var sigNivel

func _ready():
	Global.nivel = self
	if Global.UI_player:
		Global.UI_player.refrescarUI()
