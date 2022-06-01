extends Camera2D

var default_zoom: Vector2 = zoom
var smoothing: bool

var camera_smoothing_offset
var rounded_global_position

var shake_duration: float = 0
var shake_intensity: float = 0



func _ready():
	# warning-ignore:return_value_discarded
	camera_events.connect("camera_shake_request", self, "_on_camera_shake_request")

func _physics_process(delta):
	# checks if the camera is smoothing
	camera_smoothing_offset = toolbox.vector_values_to_int(get_camera_screen_center())
	rounded_global_position = toolbox.vector_values_to_int(self.global_position)
	camera_smoothing_offset = toolbox.stepify_vector(camera_smoothing_offset, 5)
	rounded_global_position = toolbox.stepify_vector(rounded_global_position, 5)
	smoothing = !(camera_smoothing_offset == rounded_global_position)
	
	execute_camera_shake(delta)



func execute_camera_shake(delta: float) -> void:
	#TODO: Game settings
	#if !Game.get_setting("Video", "CameraShake"): return
	
	if shake_duration <= 0:
		shake_duration = 0
		shake_intensity = 0
		offset = Vector2.ZERO
		return
		
	# Shakes the camera in a sine wave
	offset = Vector2(sin(OS.get_ticks_msec() * 0.03), sin(OS.get_ticks_msec() * 0.07)) * shake_intensity
	shake_duration -= delta

func shake_camera(duration: float = .5, intensity: float = .1) -> void:
	shake_duration = duration
	if intensity <= shake_intensity: return
	shake_intensity = intensity
		
func zoom_in(zoom_amount: Vector2) -> void: set_zoom(zoom_amount)
func reset_zoom() -> void: set_zoom(default_zoom)

func is_smoothing(): return smoothing



func _on_camera_shake_request(duration: float, intensity: float):
	shake_camera(duration, intensity)
