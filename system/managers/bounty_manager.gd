extends Node


func _ready():
	player_events.connect("bounty_increased", self, "_on_bounty_increased")
	

func _on_bounty_increased(value: int):
	game_data.player_data.bounty += value
	global_data_manager.save_player_data()
