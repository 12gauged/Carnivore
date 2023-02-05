extends Node2D
class_name LevelData

export(String) var level_name = "level"
export(bool) var progress_safe = false

func _ready(): 
	game_data.initial_player_bounty = game_data.get_player_data("bounty")
	game_data.progress_safe = progress_safe
	game_data.set_current_level(level_name)
	game_events.emit_signal("level_started")
	_on_level_start()
	
func _on_level_start(): pass
