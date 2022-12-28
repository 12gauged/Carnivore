extends StatusBar
	
onready var max_bar_size = len(Icons)

	
func get_first_status_value() -> int: 
	init_shader(false) # this method runs on _ready, so i'll just sneak this other method here rq lol
	return 0
	
func init_shader(value: bool):
	for Icon in Icons:
		Icon.material.set_shader_param("active", value)
	
func set_status(value: int, animate: bool = true):
	var energy_difference = value - last_status_value

	if energy_difference < 0:
		for i in range(abs(energy_difference)):
			var icon_id = value
			if animate: Icons[icon_id].play_empty_anim()
			else: Icons[icon_id].visible = false		
			
	elif energy_difference > 0:
		for i in range(energy_difference):
			var icon_id = value - (i + 1)
			if animate: 
				Icons[icon_id].play_fill_anim()
				Icons[icon_id].visible = true
			else: Icons[icon_id].visible = true
		if value < max_bar_size: play_increase_sound()
		else: play_full_sound()
		
	init_shader(value > 5)
	last_status_value = value
