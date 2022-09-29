extends Node2D

func _on_part_hitbox_hit_detected(Hurtbox):
	if game_data.get_player_data("generation") != 0: return
	
	var HitEnemy = Hurtbox.Owner
	
	if HitEnemy is Enemy and not "FROG" in HitEnemy.TAGS:
		player_events.emit_signal("archievement_made", "its_raining_frogs", true)
