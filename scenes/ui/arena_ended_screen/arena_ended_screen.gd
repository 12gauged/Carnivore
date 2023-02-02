extends Control


func _on_any_button_pressed():
	game_data.set_player_data("bounty", game_data.initial_player_bounty + game_data.level_player_bounty)
	global_data_manager.save_player_data()
	game_data.level_player_bounty = 0
