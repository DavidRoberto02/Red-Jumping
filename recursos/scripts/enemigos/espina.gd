extends StaticBody2D

func _ready():
	$Area2D.connect("area_entered", self, "on_area_entered")

func on_area_entered(area):
	if area.is_in_group("player"):
		Global.player.lastimar()


