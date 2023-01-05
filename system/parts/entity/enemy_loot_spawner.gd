extends Node2D

export(int) var drop_chance = 100
export(String) var drop_name = "meat_drop"


onready var LootSpawner = $death_loot_spawner

var can_drop: bool = true


func _ready():
	# warning-ignore:return_value_discarded
	player_events.connect("entered_eat_state", self, "disable_dropping")
	# warning-ignore:return_value_discarded
	player_events.connect("exited_eat_state", self, "enable_dropping")
	
	if game_data.current_player_state == "EAT": disable_dropping()
	
	LootSpawner.spawn_chance = drop_chance
	LootSpawner.entity_name = drop_name
	
	
func drop_loot():
	if !can_drop: return
	LootSpawner.spawn_entity()

func set_drop_chance(value: int): drop_chance = value

func allow_dropping(value: bool): can_drop = value
func disable_dropping(): allow_dropping(false)
func enable_dropping(): allow_dropping(true)
