extends StaticBody2D


onready var interact_hint = $interact_hint
onready var sprite = $Sprite

var player_close: bool = false



func _ready():
	gui_events.connect("warning_request_accepted", self, "on_request_accepted")
	gui_events.connect("warning_request_rejected", self, "on_request_rejected")
	player_events.connect("player_interacted", self, "on_player_interacted")
	

func _on_part_tag_detector_tag_detected(): 
	interact_hint.show()
	sprite.modulate = Color.yellow
	player_close = true
func _on_part_tag_detector_tag_exited(): 
	interact_hint.hide()
	sprite.modulate = Color.white
	player_close = false
	
func on_request_accepted(id):
	if id != "go_to_arena": return
	game_events.emit_signal("change_scene_request", "arena", true, 0.2)
	
func on_request_rejected(id):
	if id != "go_to_arena": return
	player_events.emit_signal("unfreeze_player")
	
	
func on_player_interacted():
	if not player_close: return
	gui_events.emit_signal("warning_request", "go_to_arena", tr("ui.jail.go_to_arena"), true, true)
