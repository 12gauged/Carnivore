extends YSort

onready var Spawners: Node2D = $Spawners
onready var SpawnDelayTimer: Timer = $spawn_delay

func _ready():
	if game_data.get_player_data("generation") >= 0:
		for spawner in Spawners.get_children():
			spawner.allow_auto_spawning()
		return
	for spawner in Spawners.get_children():
		SpawnDelayTimer.connect("timeout", spawner, "allow_auto_spawning")
		SpawnDelayTimer.connect("timeout", spawner, "spawn_entity")
