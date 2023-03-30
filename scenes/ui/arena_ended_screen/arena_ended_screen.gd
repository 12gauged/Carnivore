extends Control


func _on_any_button_pressed():
	var new_bounty = game_data.initial_player_bounty + game_data.level_player_bounty
	game_data.set_player_data("bounty", new_bounty)
	
	if new_bounty >= game_data.get_player_bounty_target():
		game_data.update_player_bounty_target() 
	
	global_data_manager.save_player_data()
	game_data.level_player_bounty = 0
