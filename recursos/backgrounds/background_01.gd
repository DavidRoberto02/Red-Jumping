extends ParallaxBackground

const VELOCIDAD_FONDO = 2
const VELOCIDAD_NUBES = 1

func _process(delta):
	$cielo.motion_offset.x -= VELOCIDAD_FONDO
	$nube1.motion_offset.x -= VELOCIDAD_NUBES

	pass
