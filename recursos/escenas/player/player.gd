extends KinematicBody2D

var muerto = false
var controlable = true
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
var monedasActuales = 0
var herible = true
var muertePorCaida = false

func _ready():
	Global.player = self
	$AnimationPlayer.connect("animation_finished", self, "animacion_finalizada")
	set_process(true)

func _process(delta):
	if !muerto && controlable:
		gestionarMovimiento()
		gestionarAnimaciones()
		gestionarColisiones()
		gestionarGravedad()
	
	if muerto && controlable:
		controlable = false
		muerte()
	
	# Gravedad
	motion.y += GRAVEDAD
	
	if !muerto:
		motion = move_and_slide_with_snap(motion, SNAP_VECTOR, Vector2(0, -1), true, 4, deg2rad(60))
	else:
		set_rotation_degrees(get_rotation_degrees() + 2)
		motion = move_and_slide(motion, Vector2(0, -1))
	
	verificarMuertePorCaida()

func gestionarMovimiento():
	# Dirección horizontal
	direccion.x = int(Input.is_action_pressed("tecla_d")) - int(Input.is_action_pressed("tecla_a"))
	direccion.y = int(Input.is_action_just_pressed("tecla_w"))
	motion.x = direccion.x * VELOCIDAD

func gestionarGravedad():
	if enElSuelo:
		SNAP_VECTOR = SNAP_DEFAULT
		puedeSaltar = true
		saltando = false
	else:
		puedeSaltar = false
	
	if direccion.y == 1 && enElSuelo && puedeSaltar && !saltando:
		saltar()

func saltar():
	SNAP_VECTOR = Vector2(0, 0)
	saltando = true
	motion.y = direccion.y * -ALTURA_SALTO

func gestionarAnimaciones():
	if motion.x != 0:
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

func lastimar():
	if herible && !muerto:
		herible = false
		$Area2D.monitoring = false
		vidas = vidas - 1
		if Global.UI_player:
			Global.UI_player.refrescarUI()
		if vidas > 0:
			$AnimationPlayer.play("herido")
			$fx_herido.play()
		else:
			morir()

func morir():
	muerto = true
	$colision.queue_free()
	$Area2D.queue_free()
	$partesCuerpo/AnimationPlayer.play("IDLE")
	$fx_muerte.play()

func animacion_finalizada(animacion):
	if animacion == "herido":
		herible = true
		$Area2D.monitoring = true

func muerte():
	#SNAP_VECTOR = SNAP_DEFAULT
	motion.y -= 400
	motion.x = 0

func verificarMuertePorCaida():
	if position.y > Global.get_screen_size().y + 500:
		#muerto = true
		if !muertePorCaida:
			muertePorCaida = true
			Global.fade.crecer()
