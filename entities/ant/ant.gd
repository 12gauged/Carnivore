extends Enemy

onready var DeathLootSpawner = $death_loot_spawner


func _ready():
	# warning-ignore:return_value_discarded
	player_events.connect("status_value_update", self, "_on_player_status_value_update")


func _on_rock_spawned(InstancedEntity):
	if !is_instance_valid(AI_TARGET): return
	InstancedEntity.direction = global_position.direction_to(AI_TARGET.global_position)
	InstancedEntity.set_hitbox_tags(["ENEMY_PROJECTILE"])
	
	
func _on_player_status_value_update(id, value):
	if id != "hunger": return
	
	if value < 2: DeathLootSpawner.set_spawn_chance(80)
	elif value > 4: DeathLootSpawner.set_spawn_chance(30)
	else: DeathLootSpawner.set_spawn_chance(60)
		
