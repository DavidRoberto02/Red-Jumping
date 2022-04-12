extends StaticBody2D

func _ready():
	$Area2D.connect("area_entered", self, "on_area_entered")
	$fx_moneda.connect("finished", self, "fx_end")

func on_area_entered(area):
	if area.is_in_group("player"):
		Global.incrementar_monedas(1)
		$Tween.interpolate_property(self, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 0.3, Tween.TRANS_SINE, Tween.EASE_OUT)
		$Tween.start()
		$fx_moneda.play()

func fx_end():
	self.queue_free()
