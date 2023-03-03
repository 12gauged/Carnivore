extends Label


func _ready():
	yield(get_tree().create_timer(0.1), "timeout") ## makes sure this only runs after the game_data ready func, otherwise the initial bounty will always be 0
	self.visible = false
	if game_data.initial_player_bounty == game_data.DEFAULT_BOUNTY: return
	# warning-ignore:return_value_discarded
	game_events.connect("arena_ended", self, "_on_arena_ended")
	
func _on_arena_ended(): self.visible = true
