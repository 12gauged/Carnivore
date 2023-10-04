extends Node2D
class_name DropSpawner


signal drop_spawned
signal spawned_drop_collected
@export_category("Config")
@export var auto_spawn: bool = false
@export var spawn_radius: float = 10.0
@export_enum("spawn_once", "spawn_after_being_collected", "spawn_infinite") var behavior: String = "spawn_once"
@export_category("Data")
@export var spawn_drop_data: DropData
@export var drop_scene: PackedScene
@export_category("Nodes")
var can_spawn: bool = true
@onready var objects_group: Node2D = get_tree().get_first_node_in_group("objects")
@onready var spawn_delay: Timer = $SpawnDelay


func _ready() -> void:
	if auto_spawn:
		spawn_drop()
	timer_setup()
	
	
func timer_setup() -> void:
	spawn_delay.one_shot = behavior != "spawn_infinite"


func spawn_drop() -> void:
	if not can_spawn:
		return
	
	var new_drop: Drop = drop_scene.instantiate()
	objects_group.add_child.call_deferred(new_drop)
	new_drop.set_global_position(get_drop_spawn_position())
	new_drop.set_data(spawn_drop_data)
	
	match behavior:
		"spawn_after_being_collected": 
			new_drop.collected.connect(_on_drop_collected)
		"spawn_once":
			can_spawn = false
		"spawn_infinite":
			spawn_delay.start()
			
			
func get_drop_spawn_position() -> Vector2:
	randomize()
	var result: Vector2 = Vector2(randi(), randi())
	result = result.normalized()
	result *= randf_range(0.1, 1.0)
	result *= spawn_radius
	result = self.global_position + result
	
	return result


func _on_drop_collected() -> void:
	if behavior != "spawn_after_being_collected":
		return
	spawn_delay.start()


func _on_spawn_delay_timeout():
	spawn_drop()
