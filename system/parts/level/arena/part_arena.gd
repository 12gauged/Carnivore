extends Node2D

signal wave_ended
signal wave_started
signal arena_ended

export(String) var FILLER_ENEMY
export(Array) var enemy_spawn_data

export(int) var number_of_waves = 1
export(int) var number_of_extra_waves_per_gen = 0
export(float) var max_enemy_counter_modifier = 0.3
export(int) var enemies_per_wave = 1
export(float) var enemies_per_wave_modifier = 1.4
export(float) var spawn_chance_modifier = 1.2
export(int) var time_between_waves = 6

onready var wave_start_delay: Timer = $wave_start_delay

const WAVE_CAP: int = 15
const MIN_WAVES: int = 10
const MAX_DIFFICULTY: int = 16
const MAX_HEAVY_ENEMY_SPAWN_CHANCE: int = 60
const TUTORIAL_WAVES: int = 6
const ENEMY_CAP: int = 15

var arena_state: int = STOPPED
enum {
	RUNNING,
	STOPPED,
	IN_BETWEEN_WAVES
}

var max_enemy_number: int
var enemy_id: int = 0
var enemy_data: Array
var enemy_spawner_id = null
var enemy_name: String
var enemy_counter: Dictionary = {}
var dead_enemies: Array = []

var last_max_enemy_number: int = 0
var initial_max_enemy_number: int = 0
var initial_enemies_per_wave_value: int = 0

var enemies_to_spawn: int = 0

var SpawnedEnemy: Enemy
var Spawners: Array = []
var SpawnedEnemies: Array = []
var AvailableSpawners: Array = []
var ChosenSpawner = null
var ENEMY_SPAWN_DATA_LEN: int = 0

var difficulty: int


func _input(event):
	if !OS.is_debug_build(): return
	if event.is_action_pressed("debug_f2"):
		end_wave()
		free_all_enemies()
		
		

func _ready():
	game_data.current_arena_wave = 1
	
	var player_bounty: float = game_data.get_player_data("bounty")
	difficulty = int(min(MAX_DIFFICULTY, ceil(player_bounty / 500.0 * int(player_bounty > 100))))
	number_of_waves += difficulty
	
	number_of_waves = clamp(number_of_waves, MIN_WAVES, WAVE_CAP)
	if player_bounty == game_data.DEFAULT_BOUNTY:
		number_of_waves = TUTORIAL_WAVES
	
	
	debug_log.dprint("\nnumber_of_waves: %s\ndifficulty: %s" % [number_of_waves, difficulty])
	
	initial_enemies_per_wave_value = enemies_per_wave
	
	max_enemy_number = max(int(float(enemies_per_wave) * 0.25), 1)
	initial_max_enemy_number = max_enemy_number
	
	enemy_counter = {FILLER_ENEMY: 0}
	ENEMY_SPAWN_DATA_LEN = len(enemy_spawn_data) - 1
	Spawners = get_node("spawners").get_children()




func free_all_enemies():
	for AliveEnemy in get_tree().get_nodes_in_group("enemies")[0].get_children():
		if is_instance_valid(AliveEnemy):
			AliveEnemy.queue_free()
	enemy_id = 0
	enemy_counter = {FILLER_ENEMY: 0}
			



func spawn_new_enemy(count_enemy := true):
	toolbox.SystemRNG.randomize()
	enemy_name = get_random_enemy()
	
	if AvailableSpawners.empty(): 
		AvailableSpawners = Spawners.duplicate()
		if is_instance_valid(ChosenSpawner): AvailableSpawners.remove(AvailableSpawners.find(ChosenSpawner))
	
	enemy_spawner_id = toolbox.SystemRNG.randi_range(0, len(AvailableSpawners) - 1)
	ChosenSpawner = AvailableSpawners[enemy_spawner_id]
	ChosenSpawner.set_entity(enemy_name)
	SpawnedEnemy = ChosenSpawner.spawn_entity()
	AvailableSpawners.remove(enemy_spawner_id)
	
	if !count_enemy: return SpawnedEnemy
	
	enemy_id += 1
	enemy_counter[enemy_name] += 1
	
	# warning-ignore:return_value_discarded
	SpawnedEnemy.connect("dead", self, "_on_enemy_killed")
	
	
func spawn_new_enemy_uncounted(): ## used only in the tutorial
	var NewEnemy = spawn_new_enemy(false)
	NewEnemy.call_deferred("enable_highlight") ## method only exists in the ant script
	NewEnemy.connect("deleted", self, "_on_tutorial_ant_killed")
	
	
func get_random_enemy() -> String:
	var result: String = FILLER_ENEMY
	var EnemyData = enemy_spawn_data[toolbox.SystemRNG.randi_range(0, ENEMY_SPAWN_DATA_LEN)]
	var check_results = check_enemy_conditions(EnemyData) 
	result = check_results if check_results != "" else result
	return result
	
		
func check_enemy_conditions(data: EntityArenaData) -> String:
	if game_data.current_arena_wave < data.wave_requirement - data.wave_requirement_reducing_modifier * difficulty: return ""
	if !enemy_counter.has(data.entity_name): enemy_counter[data.entity_name] = 0
	if enemy_counter[data.entity_name] >= data.max_number_per_wave: return ""
	if game_data.get_player_data("bounty") < data.min_bounty: return ""
	
	# increases the chance of heavy enemies to spawn by the end of the wave
	if data.spawn_chance < MAX_HEAVY_ENEMY_SPAWN_CHANCE: 
		data.spawn_chance += 5 * int(enemy_id * 0.25) # quick division by 4
		
	if !toolbox.SystemRNG.randi_range(0, 100) <= data.spawn_chance - 1 + floor(difficulty * spawn_chance_modifier): return ""
	return data.entity_name
	
func get_spawner_count() -> int: return len(Spawners)
func trigger_spawner(spawner_id: int, entity_name: String):
	return Spawners[spawner_id].spawn_entity(entity_name)




func start_arena():
	if arena_state != STOPPED: return
	arena_state = RUNNING
	start_wave()


func start_wave():
	arena_state = RUNNING
	emit_signal("wave_started")
	player_events.emit_signal("set_stat_value", "can_get_hungry", true)
	enemies_to_spawn = enemies_per_wave	
	spawn_first_enemies()
	
func spawn_first_enemies():
	for _i in range(max_enemy_number):
		spawn_new_enemy()
	



func end_wave():
	if game_data.current_arena_wave == number_of_waves:
		end_arena()
		return
	
	game_data.current_arena_wave += 1
	arena_state = IN_BETWEEN_WAVES
	
	enemy_id = 0
	enemy_counter = {FILLER_ENEMY: 0}
	
	enemies_per_wave = ceil(initial_enemies_per_wave_value + enemies_per_wave_modifier * game_data.current_arena_wave)
	max_enemy_number = enemies_per_wave * 0.5
	max_enemy_number = min(max_enemy_number, ENEMY_CAP)
	
	if game_data.initial_player_bounty < game_data.DEFAULT_BOUNTY + 10:
		enemies_per_wave = int(min(15.0, float(enemies_per_wave)))
		max_enemy_number = int(min(2.0, float(max_enemy_number)))
	
	player_events.emit_signal("set_stat_value", "can_get_hungry", false)
	game_events.emit_signal("wave_finished")
	wave_start_delay.start(time_between_waves)
	emit_signal("wave_ended")
	
	
func end_arena():
	emit_signal("arena_ended")
	game_events.emit_signal("arena_ended")
	arena_state = STOPPED
	
	
	
func _on_enemy_killed(_id): 
	if enemies_to_spawn > 0:
		enemies_to_spawn -= 1
		spawn_new_enemy()
	elif toolbox.get_node_in_group("enemies").get_child_count() == 1:
		end_wave()
	
	
	
func _on_tutorial_ant_killed(): game_events.emit_signal("tutorial_ant_dead")

func _on_arena_start_request(): start_wave()
func _on_wave_start_delay_timeout():start_wave()
