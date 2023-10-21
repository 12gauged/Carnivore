extends Node
class_name Stat


signal reached_min_value
signal reached_max_value
signal overflowing
signal value_updated(new_value)
@export var max_value: int:
	set = set_max_value,
	get = get_max_value
@export var min_value: int:
	set = set_min_value,
	get = get_min_value
@export var value: int:
	set = set_value,
	get = get_value
	
	
func decrease_value(amount: int = 1) -> void:
	set_value(value - amount)
	if get_value() > min_value: return
	reached_min_value.emit()
	
	
func increase_value(amount: int = 1) -> void:
	if get_value() == max_value:
		overflowing.emit()
		return
	set_value(value + amount)
	if get_value() < max_value: 
		return
	reached_max_value.emit()
	
	
func set_value(new_value: int) -> void: 
	value = clamp(new_value, min_value, max_value)
	value_updated.emit(value)
	

func get_value() -> int: 
	return value


func set_max_value(new_max_value: int) -> void:
	max_value = new_max_value


func get_max_value() -> int:
	return max_value
	
	
func set_min_value(new_min_value: int) -> void:
	min_value = new_min_value


func get_min_value() -> int:
	return min_value
