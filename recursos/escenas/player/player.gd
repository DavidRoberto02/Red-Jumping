extends KinematicBody2D

var direccion = Vector2()
var motion = Vector2()
const VELOCIDAD = 150
const GRAVEDAD = 100

func _ready():
	set_process(true)

func _process(delta):
	direccion.x = int(Input.is_action_pressed("tecla_d")) - int(Input.is_action_pressed("tecla_a"))
	motion.x = direccion.x * VELOCIDAD
	gestionarAnimaciones()
	move_and_slide(motion, Vector2(0, -1))

func gestionarAnimaciones():
	if direccion.x != 0:
		$partesCuerpo/AnimationPlayer.play("Caminando")
		if direccion.x == 1:
			$partesCuerpo.scale = Vector2(1, 1)
		if direccion.x == -1:
			$partesCuerpo.scale = Vector2(-1, 1)
	else:
		$partesCuerpo/AnimationPlayer.play("IDLE")
	pass
