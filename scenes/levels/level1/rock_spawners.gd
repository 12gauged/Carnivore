extends YSort

onready var Spawners: Node2D = $Spawners
onready var SpawnDelayTimer: Timer = $spawn_delay

func _ready():
	if game_data.get_player_data("generation") >= 0:
		for spawner in Spawners.get_children():
			spawner.allow_auto_spawning()
		
func spawn_tutorial_stones():
	for spawner in Spawners.get_children():
		spawner.allow_auto_spawning()
		spawner.RespawnDelayTimer.start(0.2)
		print("spawning tutorial stone")
