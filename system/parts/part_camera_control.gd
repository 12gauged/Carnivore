extends RemoteTransform2D


func _ready():
	# warning-ignore:return_value_discarded
	camera_events.connect("camera_control_state_updated", self, "_on_camera_control_state_updated")
	

func _on_camera_control_state_updated(value: bool):
	self.update_position = value
