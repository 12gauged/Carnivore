extends Position2D

signal focused

export var smoothing_speed = 8.0

onready var CameraRemote: RemoteTransform2D = $camera_control
onready var CurrentCamera: Camera2D = toolbox.get_node_in_group("camera")

var focus_signal_emitted: bool = false
var is_focusing: bool = false



func _ready():
	CameraRemote.remote_path = CurrentCamera.get_path()

func _input(event):
	if event.is_action_pressed("ui_page_down"): unfocus()
	if event.is_action_pressed("ui_page_up"): focus()

func _process(_delta):
	if !CurrentCamera.is_smoothing() and is_focusing:
		if not focus_signal_emitted:
			emit_signal("focused")
			focus_signal_emitted = true



func focus():
	CurrentCamera.smoothing_speed = smoothing_speed
	camera_events.emit_signal("camera_control_state_updated", false)
	CameraRemote.update_position = true
	is_focusing = true
	
func unfocus():
	CurrentCamera.smoothing_speed = toolbox.DEFAULT_CAMERA_SMOOTHING_SPEED
	camera_events.emit_signal("camera_control_state_updated", true)
	CameraRemote.update_position = false
	is_focusing = false
