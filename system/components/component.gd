extends Node2D
class_name Component

# warning-ignore:unused_signal
signal component_value_update(value)

export(bool) var auto_execute = true
export(String, "all", "desktop", "mobile") var platform = "all"

onready var Owner
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

func set_owner(OwnerNode):
	Owner = OwnerNode
	
func resume_execution(): can_execute = true
func stop_execution(): can_execute = false
