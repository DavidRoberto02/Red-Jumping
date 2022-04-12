extends KinematicBody2D

var motion = Vector2(0, 0)
var relaxed = true
var triggered = false
var enElSuelo = false
var goingUp = false
export(int) var GRAVEDAD = 600
var originalPos = Vector2(0, 0)

func _ready():
	originalPos = position
	$dangerZone.connect("area_entered", self, "on_dangerZone_entered")
	$contact.connect("area_entered", self, "on_contact_entered")
	$Timer.connect("timeout", self, "goBackToOriginalPos")
	set_process(true)

func _process(delta):
	if !relaxed:
		if triggered && !enElSuelo && !goingUp:
			motion.y = GRAVEDAD
		if triggered && enElSuelo:
			motion.y = 0
		if triggered && !enElSuelo && goingUp:
			motion.y = -GRAVEDAD
			
		if $RayCast2D.is_colliding():
			if !enElSuelo && !goingUp:
				enElSuelo = true
				$fx_aterrizar.play()
				Global.camara.shake(2, 100, 6)
				$Timer.start()
		
		if position.y < originalPos.y:
			motion.y = 0
			relaxed = true
			triggered = false
			goingUp = false
			position.y = originalPos.y
	
	motion = move_and_slide(motion, Vector2(0, -1))

func on_dangerZone_entered(area):
	if area.is_in_group("player") && relaxed:
		relaxed = false
		triggered = true

func on_contact_entered(area):
	if area.is_in_group("player"):
		Global.player.lastimar()

func goBackToOriginalPos():
	enElSuelo = false
	goingUp = true
