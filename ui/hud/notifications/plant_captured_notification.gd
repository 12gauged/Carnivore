extends Label


func _ready():
	self.visible = false
	gui_events.connect("show_plant_capture_notification", self, "_on_show_request")
	
func _on_show_request(): self.visible = true
