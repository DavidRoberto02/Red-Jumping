extends CanvasLayer

func _ready():
	Global.UI_player = self

func _process(delta):
	pass

func refrescarUI():
	var corazones
	var monedas
	
	if Global.player:
		corazones = Global.player.vidas
		monedas = Global.player.monedasActuales
	
	if Global.nivel:
		$corazones/Label.text = "x " + str(corazones)
		$monedas/Label.text = "x " + str(monedas) + " / " + str(Global.nivel.monedasParaAbrir)
