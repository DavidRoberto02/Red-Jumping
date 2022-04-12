extends Sprite

export(String) onready var escenaARedirigir = get_tree().current_scene.filename
var escalas = [Vector2(0, 0), Vector2(4, 4)]
var duracionTween = 1.0

func _ready():
	Global.fade = self
	
	# Lo hacemos visible y lo posicionamos en el centro nuestro fade
	visible = true
	var screen = Global.get_screen_size()
	position = Vector2(screen.x / 2, screen.y / 2)
	
	# activamos la señal de nuestros dos tweens
	$tweenCrecer.connect("tween_completed", self, "on_tweenCrecer_completed")
	$tweenDecrecer.connect("tween_completed", self, "on_tweenDecrecer_completed")
	decrecer()

func crecer():
	scale = escalas[0]
	$tweenCrecer.interpolate_property(self, "scale", escalas[0], escalas[1], duracionTween, Tween.TRANS_SINE, Tween.EASE_OUT)
	$tweenCrecer.start()

func decrecer():
	scale = escalas[1]
	$tweenDecrecer.interpolate_property(self, "scale", escalas[1], escalas[0], duracionTween, Tween.TRANS_SINE, Tween.EASE_OUT)
	$tweenDecrecer.start()

func on_tweenCrecer_completed(obj, key):
	get_tree().change_scene(escenaARedirigir)

func on_tweenDecrecer_completed(obj, key):
	pass





