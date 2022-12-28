extends Node2D


const TUTORIAL_BOUNTY_OFFSET = 200
const BOUNTY_OFFSET_MULTIPLIER = 0.5

onready var FlagSpawner: Node2D = $flag_spawner
var can_spawn: bool = true
var initial_player_bounty: int = 0
var bounty_offset: int = 0
var target_bounty: int = 0
var target_bounty_multiplier


func _ready():
	initial_player_bounty = game_data.get_player_data("bounty")
	bounty_offset = initial_player_bounty * BOUNTY_OFFSET_MULTIPLIER if initial_player_bounty > game_data.DEFAULT_BOUNTY else TUTORIAL_BOUNTY_OFFSET
	target_bounty = initial_player_bounty + bounty_offset
	debug_log.dprint("\ntarget_bounty: %s" % target_bounty)
	debug_log.dprint("level_player_bounty: %s" % game_data.level_player_bounty)
	debug_log.dprint("initial_player_bounty: %s" % initial_player_bounty)
	

func _on_flag_spawner_entity_spawned(InstancedEntity):
	can_spawn = false
	InstancedEntity.connect("deleted", self, "_on_flag_deleted")
	
	
func _on_flag_deleted():
	can_spawn = true


func _on_part_arena_wave_started():
	if !can_spawn: return
	debug_log.dprint("\nflag expected value: %s\ncurrent_value: %s" % [target_bounty, initial_player_bounty + game_data.level_player_bounty])
	if initial_player_bounty + game_data.level_player_bounty >= target_bounty:
		FlagSpawner.spawn_entity()
		bounty_offset += bounty_offset * BOUNTY_OFFSET_MULTIPLIER
		target_bounty += bounty_offset
		debug_log.dprint("\ntarget_bounty: %s" % target_bounty)
		debug_log.dprint("level_player_bounty: %s" % game_data.level_player_bounty)
