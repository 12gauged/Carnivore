extends Node2D
class_name Spawner


@export_category("Spawner Config")
@export var auto_spawn: bool = false
@export_enum("here", "specific_position") var spawn_point: String = "here"
@export_category("Node Spawn Config")
@export var spawn_group: String = "objects":
	set = set_spawn_group,
	get = get_spawn_group
@export var node_scene: PackedScene:
	set = set_node_scene
@onready var parent: Node = get_tree().get_first_node_in_group(spawn_group)


func _ready() -> void:
	if auto_spawn:
		spawn()
	
	
func spawn(pos = null) -> Node:
	if node_scene == null:
		push_error("node_scene is null")
		return null
		
	if spawn_point == "here" and pos != null:
		push_warning("trying to spawn at specific position when spawn_point is set to 'here'")
		
	if not parent:
		return
		
	var new_node = node_scene.instantiate()
	parent.add_child.call_deferred(new_node)
	
	if not new_node is Node2D: 
		return new_node
	
	if spawn_point == "here":
		new_node.global_position = self.global_position
		return new_node
	
	if pos == null:
		push_error("spawn_point is set to 'specific_position' but a position was not given(pos == null).")
		return new_node
		
	new_node.global_position = pos
	return new_node
	
	
func set_spawn_group(value: String) -> void:
	spawn_group = value
	
	
func get_spawn_group() -> String:
	return spawn_group
	
	
func set_node_scene(value: PackedScene) -> void:
	node_scene = value
