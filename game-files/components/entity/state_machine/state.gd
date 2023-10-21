extends Node2D
class_name State


signal state_exited
signal state_entered
var active: bool = false:
	set = set_active


func _ready() -> void:
	set_child_process(false)
	set_active(active)
	
	
func set_child_process(value: bool) -> void:
	for child in get_children():
		child.set_process(value)
		child.set_physics_process(value)


func enter_state() -> void:
	set_active(true)
	state_entered.emit()
	set_child_process(true)
	
	
func leave_state() -> void:
	set_active(false)
	state_exited.emit()
	set_child_process(false)


func set_active(value: bool) -> void:
	active = value
	set_process.call_deferred(value)
	set_physics_process.call_deferred(value)
