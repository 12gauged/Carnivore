extends Node2D

const BOUNTY_OFFSET = 100

onready var FlagSpawner: Node2D = $flag_spawner
var can_spawn: bool = true
var target_bounty: int = 0

func _ready():
	target_bounty = game_data.get_player_data("bounty") + BOUNTY_OFFSET


func _process(delta):
	if !can_spawn: return
	if game_data.level_player_bounty >= target_bounty:
		FlagSpawner.spawn_entity()
		target_bounty += BOUNTY_OFFSET


func _on_flag_spawner_entity_spawned(InstancedEntity):
	can_spawn = false
	InstancedEntity.connect("deleted", self, "_on_flag_deleted")
	
func _on_flag_deleted():
	can_spawn = true
