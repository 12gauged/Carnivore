extends TextureRect

onready var outline_material: ShaderMaterial = $TouchScreenButton.material

var dark_gray = Color(0.25, 0.25, 0.25, 1.0)

func _ready():
	set_shader_color(dark_gray)
	
	
func set_shader_color(color):
	material.set_shader_param("overlay_color", color)
	outline_material.set_shader_param("overlay_color", color)


func _on_set_normal_event_event_received(): 
	debug_log.dprint("special_attack_button_visuals.gd: normal")
	set_shader_color(Color.white)
func _on_set_yellowscale_event_event_received(): 
	debug_log.dprint("special_attack_button_visuals.gd: yellow")
	set_shader_color(Color.yellow)
func _on_set_grayscale_event_event_received(): 
	debug_log.dprint("special_attack_button_visuals.gd: gray")
	set_shader_color(dark_gray)
