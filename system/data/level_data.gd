extends Node2D
class_name LevelData

export(String) var level_name = "level"
export(bool) var progress_safe = false
export(bool) var skills_disabled = false

func _ready(): 
	if on_tutorial(): game_data.update_player_bounty_target()
	
	game_data.initial_player_bounty = game_data.get_player_data("bounty")
	game_data.progress_safe = progress_safe
	game_data.skills_disabled = skills_disabled
	game_data.set_current_level(level_name)
	game_events.emit_signal("level_started")
	
	game_data.cheer_intensity = 1.0
	_on_level_start()
	
func _on_level_start(): pass

func on_tutorial(): return game_data.player_data.bounty == game_data.DEFAULT_BOUNTY
