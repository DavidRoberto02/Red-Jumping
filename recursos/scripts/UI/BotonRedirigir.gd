extends Button

export(String) var escenaARedirigir = ""
export(bool) var salirDelJuego = false

func _ready():
	self.connect("button_up", self, "on_button_up")

func on_button_up():
	if !salirDelJuego:
		Global.fade.escenaARedirigir = escenaARedirigir
		Global.fade.crecer()
	else:
		get_tree().quit()
