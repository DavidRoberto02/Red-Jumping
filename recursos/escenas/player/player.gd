extends KinematicBody2D

var direccion = Vector2()
var motion = Vector2()
const VELOCIDAD = 250
const GRAVEDAD = 30
const ALTURA_SALTO = 900
var enElSuelo = false
var puedeSaltar = true

func _ready():
	set_process(true)

func _process(delta):
	gestionarMovimiento()
	gestionarAnimaciones()
	gestionarColisiones()
	
	move_and_slide(motion, Vector2(0, -1))

func gestionarMovimiento():
	# Dirección horizontal
	direccion.x = int(Input.is_action_pressed("tecla_d")) - int(Input.is_action_pressed("tecla_a"))
	direccion.y = int(Input.is_action_just_pressed("tecla_w"))
	motion.x = direccion.x * VELOCIDAD
	# Gravedad
	motion.y += GRAVEDAD
	
	if !enElSuelo:
		print("fuera del suelo")
		puedeSaltar = false
	else:
		print("dentro del suelo")
		puedeSaltar = true
		#motion.y = 0
	
	if direccion.y == 1 && enElSuelo && puedeSaltar:
		print("Saltando")
		motion.y = -ALTURA_SALTO
	
func gestionarAnimaciones():
	if direccion.x != 0:
		$partesCuerpo/AnimationPlayer.play("Caminando")
		if direccion.x == 1:
			$partesCuerpo.scale = Vector2(1, 1)
		if direccion.x == -1:
			$partesCuerpo.scale = Vector2(-1, 1)
	else:
		$partesCuerpo/AnimationPlayer.play("IDLE")

func gestionarColisiones():
	if $colision/RayCast2D.is_colliding() || $colision/RayCast2D2.is_colliding():
		enElSuelo = true
	else:
		enElSuelo = false



