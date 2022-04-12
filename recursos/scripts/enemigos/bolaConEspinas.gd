extends Node2D

export(String, "rotatorio", "swing") var modo = "rotatorio"
export(float) var gradosMaxSwing = 40
export(float) var tiempoSwing = 2
onready var area = get_node("cadenas/bola/Area2D")
onready var cadenas = get_node("cadenas")
var tweenTriggered = false

func _ready():
	area.connect("area_entered", self, "on_area_entered")
	$Tween1.connect("tween_completed", self, "tween1_completed")
	$Tween2.connect("tween_completed", self, "tween2_completed")
	set_process(true)

func _process(delta):
	if modo == "rotatorio":
		cadenas.set_rotation_degrees(cadenas.get_rotation_degrees() - 1)
	if modo == "swing" && !tweenTriggered:
		swingToRight()
		tweenTriggered = true
	
func swingToRight():
	$Tween1.interpolate_property(cadenas, "rotation_degrees", gradosMaxSwing, -gradosMaxSwing, tiempoSwing, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	$Tween1.start()
	$fx_cadenas.play()

func swingToLeft():
	$Tween2.interpolate_property(cadenas, "rotation_degrees", -gradosMaxSwing, gradosMaxSwing, tiempoSwing, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	$Tween2.start()
	$fx_cadenas.play()

func tween1_completed(obj, key):
	swingToLeft()

func tween2_completed(obj, key):
	swingToRight()

func on_area_entered(area):
	if area.is_in_group("player"):
		Global.player.lastimar()
