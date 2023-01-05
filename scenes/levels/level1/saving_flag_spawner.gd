extends Node2D


const TUTORIAL_BOUNTY_OFFSET = 100
const BOUNTY_OFFSET_MULTIPLIER = 0.5

onready var FlagSpawner: Node2D = $flag_spawner
var can_spawn: bool = true
var bounty_offset: int = 0
var target_bounty: int = 0
var target_bounty_multiplier
var initial_player_bounty = 0


func _ready():
	initial_player_bounty = game_data.get_player_data("bounty")
	bounty_offset = initial_player_bounty * BOUNTY_OFFSET_MULTIPLIER if initial_player_bounty > game_data.DEFAULT_BOUNTY else TUTORIAL_BOUNTY_OFFSET
	target_bounty = initial_player_bounty + bounty_offset
	


func _on_flag_spawner_entity_spawned(InstancedEntity):
	can_spawn = false
	InstancedEntity.connect("deleted", self, "_on_flag_deleted")
	
func _on_flag_deleted():
	can_spawn = true

func _on_part_arena_wave_started():
	if !can_spawn: return
	if initial_player_bounty + game_data.level_player_bounty >= target_bounty:
		FlagSpawner.spawn_entity()
		bounty_offset += bounty_offset * BOUNTY_OFFSET_MULTIPLIER
		target_bounty += bounty_offset
