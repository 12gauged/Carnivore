extends Enemy

const MIN_SPAWN_CHANCE: int = 50
const MAX_SPAWN_CHANCE: int = 80
onready var DeathLootSpawner = $death_loot_spawner

func _ready():
	var loot_spawn_chance = max(MIN_SPAWN_CHANCE, MAX_SPAWN_CHANCE - 7 * game_data.get_current_wave() - 1)
	DeathLootSpawner.set_spawn_chance(loot_spawn_chance)

func _on_rock_spawned(InstancedEntity):
	if !is_instance_valid(AI_TARGET): return
	InstancedEntity.direction = global_position.direction_to(AI_TARGET.global_position)
	InstancedEntity.set_hitbox_tags(["ENEMY_PROJECTILE"])
