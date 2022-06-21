extends Enemy

var target_position: Vector2

func _on_entity_spawned(InstancedEntity):
	if !is_instance_valid(AI_TARGET): return
	InstancedEntity.direction = global_position.direction_to(AI_TARGET.global_position)
	InstancedEntity.set_hitbox_tags(["ENEMY_PROJECTILE"])
