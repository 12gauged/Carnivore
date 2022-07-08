extends Node


var projectile_kill_tracker: Dictionary = {}

func _on_part_entity_spawner_entity_spawned(InstancedEntity):
	if game_data.get_player_data("generation") < 1: return 
	InstancedEntity.connect("collided", self, "_on_projectile_collided")
	InstancedEntity.connect("deleted", self, "_on_projectile_deleted")
	
	
func _on_projectile_collided(Hurtbox: DetectionBox, projectile): ## Ant on a stick archievement
	if !"ENEMY" in Hurtbox.TAGS: return
	if "ANT_SOLDIER" in Hurtbox.TAGS: return
	var projectile_id = projectile.name
	
	if !projectile_id in projectile_kill_tracker:
		projectile_kill_tracker[projectile_id] = 1
		return
		
	projectile_kill_tracker[projectile_id] += 1
	if projectile_kill_tracker[projectile_id] >= 3:
		player_events.emit_signal("archievement_made", "ant_on_a_stick", true)
	
func _on_projectile_deleted(projectile):
	var projectile_id = projectile.name
	if !projectile_id in projectile_kill_tracker: return
	projectile_kill_tracker[projectile_id] = 0
