extends Control


signal warn_visible
signal warn_invisible



onready var Text = $CenterContainer/popup_warn/VBoxContainer/Label
onready var AgreeButton = $CenterContainer/popup_warn/VBoxContainer2/button_holder/agree
onready var DisagreeButton = $CenterContainer/popup_warn/VBoxContainer2/button_holder/disagree


export(bool) var can_receive_requests = true


var last_request_id: String


func _ready():
	# warning-ignore:return_value_discarded
	gui_events.connect("warning_request", self, "_on_warning_requested")
	
	
func disable_requests(): can_receive_requests = false
func enable_requests(): can_receive_requests = true
	
	
	
func _on_button_pressed(id): # id can either be "rejected" or "accepted"
	gui_events.emit_signal("warning_request_%s" % id, last_request_id)
	self.visible = false
	emit_signal("warn_invisible")
	game_functions.resume_game()
	
func _on_warning_requested(id: String, text: String, show_agree_button: bool, show_disagree_button: bool):
	if !can_receive_requests: return
	
	game_functions.pause_game()
	emit_signal("warn_visible")
	self.visible = true
	DisagreeButton.visible = show_disagree_button
	AgreeButton.visible = show_agree_button
	last_request_id = id
	Text.text = tr(text)
	
	
