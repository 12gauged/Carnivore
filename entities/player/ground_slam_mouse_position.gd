extends Position2D


func _ready():
	set_process_input(game_data.get_current_platform() == "desktop")
	
	if game_data.get_current_platform() != "desktop":
		input_events.connect("player_movement_direction_updated", self, "_on_player_movement_direction_updated")


func _input(event): ## ONLY RUNS WHEN ON DESKTOP
	if !event is InputEventMouseMotion: return
	look_at(get_global_mouse_position())
	
	
func _on_player_movement_direction_updated(value):
	look_at(self.global_position + value)
