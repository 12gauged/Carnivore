extends Node2D

onready var FlagSpawner: Node2D = $flag_spawner
var can_spawn: bool = true
var bounty_offset: int = 400
var target_bounty: int = 0
var target_bounty_multiplier

func _ready():
	target_bounty = game_data.get_player_data("bounty") + bounty_offset


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
		bounty_offset *= 2
		target_bounty += bounty_offset
