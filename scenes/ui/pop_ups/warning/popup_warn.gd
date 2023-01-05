extends Control


onready var Text = $CenterContainer/popup_warn/VBoxContainer/Label
onready var AgreeButton = $CenterContainer/popup_warn/VBoxContainer2/button_holder/agree
onready var DisagreeButton = $CenterContainer/popup_warn/VBoxContainer2/button_holder/disagree


var last_request_id: String


func _ready():
	# warning-ignore:return_value_discarded
	gui_events.connect("warning_request", self, "_on_warning_requested")
	
	
func _on_button_pressed(id): # id can either be "rejected" or "accepted"
	gui_events.emit_signal("warning_request_%s" % id, last_request_id)
	self.visible = false
	
func _on_warning_requested(id: String, text: String, show_agree_button: bool, show_disagree_button: bool):
	self.visible = true
	DisagreeButton.visible = show_disagree_button
	AgreeButton.visible = show_agree_button
	last_request_id = id
	Text.text = tr(text)
	
	
