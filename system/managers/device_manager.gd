extends Node


func _ready():
	
	if OS.has_feature("JavaScript"):
		if !js_handler.setted_up: js_handler.execute_javascript_global_setup()
		var player_platform = JavaScript.eval("getPlatform()")
		game_data.set_current_platform(player_platform)
		
