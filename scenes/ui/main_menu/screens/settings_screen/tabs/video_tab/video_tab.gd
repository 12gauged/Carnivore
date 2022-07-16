extends Control



func _on_camera_shake_toggled(value: bool):
	game_data.set_game_setting("video", "camera_shake", value)
	json_data_manager.save_settings()

func _on_fullscreen_toggled(button_pressed):
	OS.window_fullscreen = button_pressed
	json_data_manager.save_settings()
