extends Control




signal screen_visible

onready var animation_player = $AnimationPlayer



func _ready():
	gui_events.connect("show_arena_ended_screen", self, "_on_arena_ended")
	self.visible = false




func _on_any_button_pressed():
	var new_bounty = game_data.initial_player_bounty + game_data.level_player_bounty
	game_data.set_player_data("bounty", new_bounty)
	
	if new_bounty >= game_data.get_player_bounty_target():
		game_data.update_player_bounty_target() 
	
	global_data_manager.save_player_data()
	game_data.level_player_bounty = 0
	game_functions.set_time_scale(1.0)
	
	
	
func _on_arena_ended():
	animation_player.play("fade_in")
	emit_signal("screen_visible")
	game_events.emit_signal("stop_music")
	player_events.emit_signal("freeze_player")
	gui_events.emit_signal("hide_hud")
