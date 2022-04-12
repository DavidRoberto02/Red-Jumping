extends StaticBody2D

var cerrada = true
var puertas = {
	"abierta":  load("res://recursos/img/environment/puerta/puerta_abierta.png"),
	"cerrada":  load("res://recursos/img/environment/puerta/puerta_cerrada.png"),
}

func _ready():
	$Sprite.texture = puertas.cerrada
	Global.puerta = self
	$Area2D.connect("area_entered", self, "on_area_entered")

func on_area_entered(area):
	if area.is_in_group("player"):
		if !cerrada:
			if Global.fade && Global.nivel:
				Global.fade.escenaARedirigir = Global.nivel.sigNivel
				Global.fade.crecer()

func refrescarPuerta():
	if Global.nivel && Global.player:
		if Global.player.monedasActuales == Global.nivel.monedasParaAbrir:
			if Global.puerta:
				Global.puerta.get_node("fx_puerta_abriendose").play()
			cerrada = false
			$Sprite.texture = puertas.abierta
			
		


