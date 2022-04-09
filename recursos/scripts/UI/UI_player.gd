extends CanvasLayer

onready var corazonSize = $Control/VBoxContainer/corazones.rect_size.x

func _ready():
	Global.UI_player = self
	refrescarUI()

func _process(delta):
	pass

func refrescarUI():
	if Global.player:
		var vidasPlayer = Global.player.vidas
		$Container/corazones.rect_size.x = vidasPlayer * corazonSize
