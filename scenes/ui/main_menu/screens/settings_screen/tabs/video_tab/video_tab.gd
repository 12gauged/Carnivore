extends Control



func _toggle_camera_shake_request(value: bool):
	game_data.set_game_setting("video", "camera_shake", value)
