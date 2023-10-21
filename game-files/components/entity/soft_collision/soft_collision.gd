extends Area2D


@export_category("Node Config")
@export var parent: CharacterBody2D
@export_category("Collision Config")
@export var push_intensity: float = 70


func _ready() -> void:
	if parent == null:
		push_error("parent was not set.")
		set_physics_process(false)
		return


func _physics_process(_delta):
	var overlaps: Array[Area2D] = get_overlapping_areas()
	var push_direction: Vector2 = Vector2.ZERO
	
	if overlaps.is_empty():
		return
		
	for overlap in overlaps:
		var overlap_pos: Vector2 = overlap.global_position
		var overlap_parent: CharacterBody2D = overlap.parent
		
		push_direction = self.global_position.direction_to(overlap_pos)
		
		overlap_parent.velocity = push_direction * push_intensity
		overlap_parent.move_and_slide()


