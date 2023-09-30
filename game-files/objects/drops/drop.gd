@tool
extends Area2D
class_name Drop


@export_enum("consumable", "projectile") var type: String = "consumable"


func _ready() -> void:
	if Engine.is_editor_hint():
		set_collision_layer_value(1, false)
		set_collision_layer_value(7, true)
		set_collision_mask_value(1, false)
		
		
func get_data():
	return null
