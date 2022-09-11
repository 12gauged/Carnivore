extends Node



func _ready():
	var player_platform
	if OS.has_feature("JavaScript"):
		if !js_handler.setted_up: js_handler.execute_javascript_global_setup()
		player_platform = JavaScript.eval("getPlatform()")
	else:
		match OS.get_name():
			"Android": player_platform = "mobile"
			_: player_platform = "desktop"
			
			
	if OS.is_debug_build() and player_platform != "mobile":
		# debug values
		player_platform = "desktop"
		pass
	game_data.set_current_platform(player_platform)
