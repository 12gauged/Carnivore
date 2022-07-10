extends Node2D

signal wave_ended
signal wave_started
signal arena_ended

export(String) var FILLER_ENEMY
export(Array) var enemy_spawn_data

export(int) var number_of_waves = 1
export(int) var number_of_extra_waves_per_gen = 0
export(int) var max_enemy_number = 1
export(float) var max_enemy_counter_modifier = 0.3
export(int) var enemies_per_wave = 1
export(float) var enemies_per_wave_modifier = 1.2
export(int) var time_between_waves = 6

onready var wave_start_delay: Timer = $wave_start_delay

var arena_state: int = STOPPED
enum {
	RUNNING,
	STOPPED,
	IN_BETWEEN_WAVES
}

var enemy_kill_count: int = 0
var enemy_id: int = 0
var enemy_data: Array
var enemy_spawner_id = null
var enemy_name: String
var enemy_counter: Dictionary = {}
var dead_enemies: int = 0
var living_enemies: int = 0

var last_max_enemy_number: int = 0
var initial_max_enemy_number: int = 0
var initial_enemies_per_wave_value: int = 0
var SpawnedEnemy: Enemy
var Spawners: Array = []
var SpawnedEnemies: Array = []
var AvailableSpawners: Array = []
var ChosenSpawner = null
var ENEMY_SPAWN_DATA_LEN: int = 0


func _input(event):
	if !OS.is_debug_build(): return
		
	if event.is_action_pressed("debug_f2"):
		end_wave()
		free_all_enemies()

func _ready():
	game_data.current_arena_wave = 1
	number_of_waves += number_of_extra_waves_per_gen * game_data.get_player_data("generation")
	initial_max_enemy_number = max_enemy_number
	initial_enemies_per_wave_value = enemies_per_wave
	enemy_counter[FILLER_ENEMY] = 0
	ENEMY_SPAWN_DATA_LEN = len(enemy_spawn_data) - 1
	Spawners = get_node("spawners").get_children()
		
func _process(_delta): 
	if arena_state != RUNNING: return
	if living_enemies < max_enemy_number and enemy_id < enemies_per_wave:
		spawn_new_enemy()
	process_enemy_deaths()



func process_enemy_deaths():
	if dead_enemies == 0: return
	enemy_kill_count += 1
	if enemy_kill_count == enemies_per_wave:
		end_wave()
	dead_enemies -= 1

func free_all_enemies():
	for AliveEnemy in SpawnedEnemies:
		if is_instance_valid(AliveEnemy):
			AliveEnemy.queue_free()
	enemy_id = 0
	enemy_kill_count = 0
	SpawnedEnemies = []
			
func spawn_first_enemies():
	spawn_new_enemy()
	last_max_enemy_number = max_enemy_number

func spawn_new_enemy():
	toolbox.SystemRNG.randomize()
	enemy_name = get_random_enemy()
	
	if AvailableSpawners.empty(): 
		AvailableSpawners = Spawners.duplicate()
		if is_instance_valid(ChosenSpawner): AvailableSpawners.remove(AvailableSpawners.find(ChosenSpawner))
	
	# gets a random spawner
	enemy_spawner_id = toolbox.SystemRNG.randi_range(0, len(AvailableSpawners) - 1)
	# Picks up the spawner from the array
	ChosenSpawner = AvailableSpawners[enemy_spawner_id]
	# configures the spawner and spawns the entity
	ChosenSpawner.set_entity(enemy_name)
	SpawnedEnemy = ChosenSpawner.spawn_entity()
	#SpawnedEnemies.append(SpawnedEnemy)
	# discards the used spawner
	AvailableSpawners.remove(enemy_spawner_id)
	
	# warning-ignore:return_value_discarded
	SpawnedEnemy.connect("dead", self, "_on_enemy_killed")
	# warning-ignore:return_value_discarded
	SpawnedEnemy.connect("ready", self, "_on_enemy_entered_scene")
	
	living_enemies += 1
	enemy_id += 1
	enemy_counter[enemy_name] += 1
	
func get_random_enemy() -> String:
	var result: String = FILLER_ENEMY
	var EnemyData = enemy_spawn_data[toolbox.SystemRNG.randi_range(0, ENEMY_SPAWN_DATA_LEN)]
	var check_results = check_enemy_conditions(EnemyData) 
	
	result = check_results if check_results != "" else result
	return result
	
		
func check_enemy_conditions(data: EntityArenaData) -> String:
	if game_data.current_arena_wave < data.wave_requirement: return ""
	if !enemy_counter.has(data.entity_name): enemy_counter[data.entity_name] = 0
	if enemy_counter[data.entity_name] >= data.max_number_per_wave: return ""
	if game_data.get_player_data("generation") < data.min_generation: return ""
	if !toolbox.SystemRNG.randi_range(0, 100) <= data.spawn_chance - 1: return ""
	
	return data.entity_name
	
	
	
func trigger_spawner(spawner_id: int, entity_name: String):
	return Spawners[spawner_id].spawn_entity(entity_name)
	
func get_spawner_count() -> int: return len(Spawners)

func start_arena():
	if arena_state != STOPPED: return
	arena_state = RUNNING
	start_wave()

func start_wave():
	arena_state = RUNNING
	emit_signal("wave_started")
	player_events.emit_signal("set_stat_value", "can_get_hungry", true)
	game_events.emit_signal("start_wave_time_tracker")

func end_wave():
	game_data.current_arena_wave += 1
	arena_state = IN_BETWEEN_WAVES
	
	if game_data.current_arena_wave == number_of_waves:
		end_arena()
		return
	
	enemy_kill_count = 0
	enemy_id = 0
	enemies_per_wave = int(initial_enemies_per_wave_value + enemies_per_wave_modifier * game_data.current_arena_wave)
	max_enemy_number = int(initial_max_enemy_number + max_enemy_counter_modifier * game_data.current_arena_wave)
	player_events.emit_signal("set_stat_value", "can_get_hungry", false)
	player_events.emit_signal("force_exit_from_eat_state")
	game_events.emit_signal("wave_finished")
	game_events.emit_signal("stop_wave_time_tracker")
	wave_start_delay.start(time_between_waves)
	emit_signal("wave_ended")
	
func end_arena():
	emit_signal("arena_ended")
	game_events.emit_signal("arena_ended")
	arena_state = STOPPED
	
	
	
func _on_enemy_killed(id): 
	dead_enemies += 1
	living_enemies -= 1
	enemy_counter[id] -= 1

func _on_arena_start_request(): 
	start_wave()

func _on_wave_start_delay_timeout():
	start_wave()
