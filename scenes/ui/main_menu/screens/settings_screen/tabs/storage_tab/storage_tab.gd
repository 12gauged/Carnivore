extends VBoxContainer


func _ready():
	gui_events.connect("warning_request_accepted", self, "_on_warning_request_accepted")


func _on_wide_button_button_pressed(_id):
	gui_events.emit_signal("warning_request", "data_erasing", "ui.warning.erase_data", true, true)
	
	
func _on_warning_request_accepted(id):
	match id:
		"data_erasing":
			game_data.reset_all_data()
			match OS.get_name():
				"HTML5": json_data_manager.reload_page()
				_: gui_events.call_deferred("emit_signal", "warning_request", "restart_game", "ui.warning.restart_game", true, false)
		"restart_game":
			get_tree().quit()
