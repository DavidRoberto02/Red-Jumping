extends KinematicBody2D

var path

func _ready():
	$Area2D.connect("area_entered", self, "on_area_entered")
	set_process(true)

func _process(delta):
	if get_parent() is PathFollow2D:
		path = get_parent()
		path.set_offset(path.get_offset() + 4)
	self.rotate(-5 * delta)

func on_area_entered(area):
	if area.is_in_group("player"):
		Global.player.lastimar()


