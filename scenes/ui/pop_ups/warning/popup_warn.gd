extends Control


onready var Text = $CenterContainer/popup_warn/VBoxContainer/Label



func _ready():
	gui_events.connect("warning_request", self, "_on_warning_requested")
	
	
func _on_button_pressed(id): # id can either be "rejected" or "accepted"
	gui_events.emit_signal("warning_request_%s" % id)
	self.visible = false
	
func _on_warning_requested(id, text):
	self.visible = true
	Text.text = tr(text)
	
	
