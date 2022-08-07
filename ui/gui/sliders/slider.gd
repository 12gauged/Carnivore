extends HSlider

signal slider_value_updated(id, new_slider_value)
export(String) var id = ""


func _input(event):
	# Prevents sliders from working with the scroll wheel
	if game_data.current_platform != "desktop": return
	
	if not event is InputEventMouseButton: return
	
	self.mouse_filter = MOUSE_FILTER_PASS
	if event.button_index in [BUTTON_WHEEL_UP, BUTTON_WHEEL_DOWN]:
		self.mouse_filter = MOUSE_FILTER_IGNORE


func _ready():
	# warning-ignore:return_value_discarded
	connect("value_changed", self, "_on_slider_changed")
	
	
func _on_slider_changed(new_value):
	emit_signal("slider_value_updated", id, new_value)
