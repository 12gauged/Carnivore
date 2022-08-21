extends Control


onready var Text = $CenterContainer/popup_warn/VBoxContainer/Label


var last_request_id: String


func _ready():
	gui_events.connect("warning_request", self, "_on_warning_requested")
	
	
func _on_button_pressed(id): # id can either be "rejected" or "accepted"
	print(last_request_id)
	gui_events.emit_signal("warning_request_%s" % id, last_request_id)
	self.visible = false
	
func _on_warning_requested(id, text):
	print("received request. id: %s" % id)
	self.visible = true
	last_request_id = id
	Text.text = tr(text)
	
	
