extends GenericCamera

export(bool) var show_hud = true


var default_zoom: Vector2 = zoom
var smoothing: bool

var camera_smoothing_offset
var rounded_global_position



func _ready():
	gui_events.emit_signal("show_hud" if show_hud else "hide_hud")

func _physics_process(delta):
	# checks if the camera is smoothing
	camera_smoothing_offset = toolbox.vector_values_to_int(get_camera_screen_center())
	rounded_global_position = toolbox.vector_values_to_int(self.global_position)
	camera_smoothing_offset = toolbox.stepify_vector(camera_smoothing_offset, 5)
	rounded_global_position = toolbox.stepify_vector(rounded_global_position, 5)
	smoothing = !(camera_smoothing_offset == rounded_global_position)
	
	execute_camera_shake(delta)
		
func zoom_in(zoom_amount: Vector2) -> void: set_zoom(zoom_amount)
func reset_zoom() -> void: set_zoom(default_zoom)

func is_smoothing(): return smoothing



func _on_camera_shake_request(duration: float, intensity: float):
	shake_camera(duration, intensity)
