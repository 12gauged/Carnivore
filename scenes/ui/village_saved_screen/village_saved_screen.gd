extends Control


func _ready():
	if game_data.get_player_data("generation") == -1:
		game_data.set_player_data("generation", 0)
		global_data_manager.save_player_data()
