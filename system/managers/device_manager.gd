extends Node


const stretch_mode: int = SceneTree.STRETCH_MODE_2D
const stretch_aspect: int = SceneTree.STRETCH_ASPECT_EXPAND
const min_screen_size: Vector2 = Vector2(240, 135)
const screen_shrink_mobile: float = 1.0
const screen_shrink_desktop: float = 0.7


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
		#player_platform = "mobile"
		pass
	set_screen_scaling(player_platform)
	game_data.set_current_platform(player_platform)
	
	

func set_screen_scaling(platform: String):
	var screen_shrink = screen_shrink_desktop if platform == "desktop" else screen_shrink_mobile
	get_tree().set_screen_stretch(
		stretch_mode,
		stretch_aspect,
		min_screen_size,
		screen_shrink
	)
