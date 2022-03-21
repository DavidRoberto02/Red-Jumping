extends KinematicBody2D

var direccion = Vector2()
var motion = Vector2()
var SNAP_DEFAULT = Vector2(0, 32)
var SNAP_VECTOR = SNAP_DEFAULT
const VELOCIDAD = 220
const GRAVEDAD = 20
const ALTURA_SALTO = 800
var enElSuelo = false
var puedeSaltar = true
var saltando = false
var vidas = 3
var monedas = 0

func _ready():
	Global.player = self
	$Area2D.connect("area_entered", self, "_on_area_entered")
	set_process(true)

func _process(delta):
	gestionarMovimiento()
	gestionarAnimaciones()
	gestionarColisiones()
	
	motion = move_and_slide_with_snap(motion, SNAP_VECTOR, Vector2(0, -1), true, 4, deg2rad(60))

func gestionarMovimiento():
	# Dirección horizontal
	direccion.x = int(Input.is_action_pressed("tecla_d")) - int(Input.is_action_pressed("tecla_a"))
	direccion.y = int(Input.is_action_just_pressed("tecla_w"))
	motion.x = direccion.x * VELOCIDAD
	
	if enElSuelo:
		SNAP_VECTOR = SNAP_DEFAULT
		puedeSaltar = true
		saltando = false
	else:
		puedeSaltar = false
		motion.y += GRAVEDAD
	
	if direccion.y == 1 && enElSuelo && puedeSaltar && !saltando:
		SNAP_VECTOR = Vector2(0, 0)
		saltando = true
		motion.y = direccion.y * -ALTURA_SALTO
	
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
	#if $RayCast2D.is_colliding() || $RayCast2D2.is_colliding():
	if is_on_floor():
		enElSuelo = true
	else:
		enElSuelo = false

func _on_area_entered(area):
	if area.is_in_group("enemigo"):
		lastimar()
	
	if area.is_in_group("moneda"):
		monedas = monedas + 1
		area.get_parent().queue_free()
	
	
	

func lastimar():
	vidas = vidas - 1
	
	if vidas > 0:
		print("sigue vivo")
	else:
		print("muerto")
	
	Global.UI_player.refrescarUI()
