extends Node2D

const BOUNTY_OFFSET = 100

onready var FlagSpawner: Node2D = $flag_spawner
var can_spawn: bool = true
var target_bounty: int = 0
var target_bounty_multiplier

func _ready():
	var player_bounty: float = game_data.get_player_data("bounty")
	target_bounty_multiplier = int(ceil(player_bounty / 100.0 * int(player_bounty > 100)) + 1)
	target_bounty = game_data.get_player_data("bounty") + BOUNTY_OFFSET * target_bounty_multiplier


func _process(delta):
	pass


func _on_flag_spawner_entity_spawned(InstancedEntity):
	can_spawn = false
	InstancedEntity.connect("deleted", self, "_on_flag_deleted")
	
func _on_flag_deleted():
	can_spawn = true


func _on_part_arena_wave_started():
	if !can_spawn: return
	if game_data.level_player_bounty >= target_bounty:
		FlagSpawner.spawn_entity()
		target_bounty += BOUNTY_OFFSET
		target_bounty *= target_bounty_multiplier
