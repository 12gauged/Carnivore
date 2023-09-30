@tool
extends Area2D
class_name Drop


@export var data: Resource


func _ready() -> void:
	if Engine.is_editor_hint():
		set_collision_layer_value(1, false)
		set_collision_layer_value(7, true)
		set_collision_mask_value(1, false)
		
		
func get_data():
	return data

