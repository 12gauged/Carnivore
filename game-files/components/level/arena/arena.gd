extends Node
class_name Arena


signal wave_ended
@export_category("Arena Configuration")
@export var intermission_duration: float = 4.0
@export var waves: int = 6
@export var enemies_per_wave: int = 10
@export var max_living_enemies: int = 2
@export_category("Enemy Configuration")
@export var enemy_datas: Array[EnemyData]
var wave: int = 1
var living_enemies: int = 0
var wave_enemies: Array[PackedScene]
var spawnpoints: Array[Marker2D]
@onready var spawner: Spawner = $Spawner
@onready var intermission_delay: Timer = $IntermissionDelay


func _ready() -> void:
	wave_ended.connect(on_wave_ended)
	start_wave()
	
	
func start_wave() -> void:
	spawnpoints = get_spawnpoints()
	wave_enemies = generate_wave_enemies()
	spawn_enemies()


func spawn_enemies() -> void:
	if wave_enemies.is_empty():
		if living_enemies == 0:
			wave_ended.emit()
		return
		
	for _i in range(max_living_enemies):
		if living_enemies == max_living_enemies:
			return
		var chosen_enemy_scene: PackedScene = wave_enemies.back()
		var spawnpoint: Vector2 = get_spawnpoint()
		spawner.set_node_scene(chosen_enemy_scene)
		
		var spawn_delay: float = randf_range(0.5, 1.0)
		await get_tree().create_timer(spawn_delay).timeout
		
		var new_enemy: Mob = spawner.spawn(spawnpoint)
		wave_enemies.pop_back()
		new_enemy.deleted.connect(on_enemy_dead)
		living_enemies += 1


func generate_wave_enemies() -> Array[PackedScene]:
	var candidates: Array[EnemyData] = []
	var result: Array[PackedScene] = []
	
	for enemy_data in enemy_datas:
		if enemy_data.spawn_wave < wave:
			continue
		candidates.append(enemy_data)
		
	for _i in range(enemies_per_wave):
		randomize()
		var chosen_enemy_id: int = randi_range(0, len(candidates) - 1)
		var chosen_enemy: PackedScene = candidates[chosen_enemy_id].enemy_scene
		result.append(chosen_enemy)
	
	result.reverse()
	
	return result
	
	
func get_spawnpoint() -> Vector2:
	var result: Vector2
	if spawnpoints.is_empty():
		spawnpoints = get_spawnpoints()
	var spawnpoint_id: int = randi_range(0, len(spawnpoints) - 1)
	result = spawnpoints[spawnpoint_id].global_position
	spawnpoints.pop_at(spawnpoint_id) ## makes that spawnpoint unavailable
	return result
	
	
func get_spawnpoints() -> Array[Marker2D]:
	var result: Array[Marker2D]
	for child in get_children():
		if not child is Marker2D: continue
		result.append(child)
	return result
	
	
func on_wave_ended() -> void:
	intermission_delay.start(intermission_duration)
	
	
func on_enemy_dead() -> void:
	living_enemies -= 1
	spawn_enemies()


func _on_intermission_delay_timeout():
	start_wave()
