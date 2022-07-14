extends HSlider

signal slider_value_updated(id, new_slider_value)
export(String) var id = ""


func _ready():
	connect("value_changed", self, "_on_slider_changed")
	
	
func _on_slider_changed(new_value):
	emit_signal("slider_value_updated", id, new_value)
