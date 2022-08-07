extends Enemy

var target_position: Vector2

func _on_entity_spawned(InstancedEntity):
	if !is_instance_valid(AI_TARGET): return
	InstancedEntity.direction = global_position.direction_to(AI_TARGET.global_position)
	InstancedEntity.call_deferred("set_hitbox_tags", ["ANT_SOLDIER_SPEAR"])
	
func _on_damage_received(Hitbox: DetectionBox):
	if get_stat("invincible") == true and !Hitbox.override_invincibility: return
	
	if "FROG" in Hitbox.TAGS: ## Gets 1 tapped by frogs lol n00b
		apply_damage(MAX_HEALTH)
		return
	apply_damage(Hitbox.damage)
