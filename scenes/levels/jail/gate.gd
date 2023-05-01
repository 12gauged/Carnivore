extends StaticBody2D




func _ready():
	gui_events.connect("warning_request_accepted", self, "on_request_accepted")
	gui_events.connect("warning_request_rejected", self, "on_request_rejected")
	
	
func on_request_accepted(id):
	if id != "go_to_arena": return
	game_events.emit_signal("change_scene_request", "arena", true, 0.2)
	
func on_request_rejected(id):
	if id != "go_to_arena": return
	player_events.emit_signal("unfreeze_player")
