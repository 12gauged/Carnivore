extends Node2D

export(String) var level_name = "level"

func _ready(): 
	game_data.set_current_level(level_name)
	game_events.emit_signal("level_started")
