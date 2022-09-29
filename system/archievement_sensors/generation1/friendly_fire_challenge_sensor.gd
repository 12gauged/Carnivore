extends Node



func _on_part_hurtbox_hit_detected(Hitbox: DetectionBox):
	if !"FROG" in Hitbox.TAGS: return
	if game_data.get_player_data("generation") < 1: return
	player_events.emit_signal("archievement_made", "friendly_fire", true)
