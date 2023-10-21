extends Node2D


signal mouse_position_updated()
signal direction_to_mouse_updated()
var mouse_position: Vector2:
	get = get_mouse_position
var direction_to_mouse: Vector2:
	get = get_direction_to_mouse


func _process(_delta) -> void:
	var mouse_position: Vector2 = get_global_mouse_position()
	var direction_to_mouse: Vector2 = get_global_position().direction_to(mouse_position)
	mouse_position_updated.emit(mouse_position)
	direction_to_mouse_updated.emit(direction_to_mouse)
	
	
func get_mouse_position() -> Vector2:
	return mouse_position
	
	
func get_direction_to_mouse() -> Vector2:
	return direction_to_mouse
	
