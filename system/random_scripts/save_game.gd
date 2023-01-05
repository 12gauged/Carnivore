extends Node2D


func save_game():
	game_data.set_player_data("bounty", game_data.level_player_bounty)
	global_data_manager.save_player_data()
