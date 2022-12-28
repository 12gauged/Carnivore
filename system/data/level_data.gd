extends Node2D

export(String) var level_name = "level"

func _ready(): 
	game_data.initial_player_bounty = game_data.get_player_data("bounty")
	game_data.set_current_level(level_name)
	game_events.emit_signal("level_started")
