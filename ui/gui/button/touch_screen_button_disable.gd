extends TouchScreenButton

export(bool) var disabled = false


onready var default_pressed_texture: Texture = pressed


func _process(_delta):
	# changes the pressed texture to the default one if the button is disabled
	pressed = normal if disabled else default_pressed_texture
	

func disable(): disabled = true
func enable(): disabled = false
