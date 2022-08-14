extends VBoxContainer


func _ready():
	gui_events.connect("warning_request_accepted", self, "_on_warning_request_accepted")


func _on_wide_button_button_pressed(id):
	gui_events.emit_signal("warning_request", "data_erasing", "ui.warning.erase_data")
	
	
func _on_warning_request_accepted():
	game_data.reset_all_data()
