extends Camera2D
class_name GenericCamera

var shake_duration: float = 0
var shake_intensity: float = 0



func _ready():
	# warning-ignore:return_value_discarded
	camera_events.connect("camera_shake_request", self, "_on_camera_shake_request")

func _physics_process(delta):
	execute_camera_shake(delta)



func execute_camera_shake(delta: float) -> void:
	if !game_data.get_game_setting("video", "camera_shake"): return
	
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



func _on_camera_shake_request(duration: float, intensity: float):
	shake_camera(duration, intensity)
