extends Node
class_name MotionHandler


signal direction_vector_updated(direction)
@export var target_node: CharacterBody2D
@export var friction: int = 400
@export var acceleration: int = 400
@export var max_speed: int = 100
var direction_vector: Vector2:
	set = set_direction_vector,
	get = get_direction_vector
	
	
func _ready() -> void:
	if not is_instance_valid(target_node):
		push_error("target_node is not valid")
		set_process(false)
		set_physics_process(false)
		return


func _physics_process(delta) -> void:
	update_direction_vector()
	target_node.velocity = target_node.velocity.move_toward(direction_vector * max_speed, acceleration * delta)
	target_node.move_and_slide()
	
	
func update_direction_vector() -> void:
	pass
	
	
func stop_moving() -> void:
	set_direction_vector(Vector2.ZERO)
	
	
func set_direction_vector(value: Vector2) -> void:
	direction_vector = value
	direction_vector_updated.emit(direction_vector)
	
	
func get_direction_vector() -> Vector2:
	return direction_vector
