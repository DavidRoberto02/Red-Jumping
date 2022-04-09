extends KinematicBody2D

func _ready():
	$Area2D.connect("area_entered", self, "on_area_entered")
	set_process(true)

func _process(delta):
	self.rotate(-5 * delta)

func on_area_entered(area):
	if area.is_in_group("player"):
		Global.player.lastimar()
	pass


