extends LevelData


func _on_level_start():
	gui_events.emit_signal("hide_hud")
