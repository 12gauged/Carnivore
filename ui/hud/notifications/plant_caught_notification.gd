extends Label


func _ready():
	if game_data.initial_player_bounty == game_data.DEFAULT_BOUNTY: return
	self.visible = false
	game_events.connect("arena_ended", self, "_on_arena_ended")
	
func _on_arena_ended(): self.visible = true
