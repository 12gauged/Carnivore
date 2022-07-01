extends Node2D
class_name Component

# warning-ignore:unused_signal
signal component_value_update(value)

export(bool) var auto_execute = true
export(String, "all", "desktop", "mobile") var platform = "all"

onready var Owner = get_owner()
var ParentState
var can_execute: bool = true



func _ready():
	var parent = get_parent()
	can_execute = game_data.get_current_platform() == platform or platform == "all"
	ParentState = parent if parent is State else null
	
func _process(delta):
	if !can_execute: return
	if auto_execute: _execute(delta)


	
func _execute(_delta): pass



func get_owner():
	var result
	var last_attempt = get_parent()
	for i in range(5):
		if last_attempt == null: break
		if "TAGS" in last_attempt and "COMP_EXECUTER" in last_attempt.TAGS:
			result = last_attempt
			break
		last_attempt = last_attempt.get_parent()
	return result
