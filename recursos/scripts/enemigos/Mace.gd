extends KinematicBody2D

var motion = Vector2(0, 0)
var relaxed = true
var triggered = false
var GRAVEDAD = 600
var originalPos = Vector2(0, 0)

func _ready():
	originalPos = position
	$dangerZone.connect("area_entered", self, "on_dangerZone_entered")
	$Timer.connect("timeout", self, "goBackToOriginalPos")
	set_process(true)

func _process(delta):
	if !relaxed:
		#if $RayCast2D.is_colliding():
		if is_on_floor():
			if triggered:
				motion.y = 0
				triggered = false
				$Timer.start()
	
		if triggered:
			motion.y = GRAVEDAD
		
		if position.y < originalPos.y:
			motion.y = 0
			relaxed = true
			triggered = false
			position.y = originalPos.y
	
	motion = move_and_slide(motion, Vector2(0, -1))

func on_dangerZone_entered(area):
	if area.is_in_group("player") && relaxed:
		relaxed = false
		triggered = true

func goBackToOriginalPos():
	motion.y = -GRAVEDAD
