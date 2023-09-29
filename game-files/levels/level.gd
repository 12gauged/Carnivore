@tool
extends Node2D
class_name Level


func _ready():
	if Engine.is_editor_hint():
		
		
		
		set_process(false)
		set_physics_process(false)
		set_process_input(false)


func _process(delta):
	pass
