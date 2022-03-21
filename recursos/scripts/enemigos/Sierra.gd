extends KinematicBody2D

func _ready():
	set_process(true)

func _process(delta):
	self.rotate(-5 * delta)
