extends Node2D
class_name State

signal state_entered
signal executing
signal state_exited

var Components: Array = []
var COMPONENT_ARRAY_LEN
var CurrentComponent

var component_id: int = -1
var execution_step: int = 0
enum {
	JUST_STARTED,
	EXECUTING,
	JUST_STOPPED
}


func _ready():
	# warning-ignore:return_value_discarded
	connect("state_exited", self, "_on_state_exited")
	Components = get_children()
	COMPONENT_ARRAY_LEN = len(Components) - 1

func _state_execute(delta):
	update_execution_step()
	execute_components(delta)
	_execute(delta)
	emit_signal("executing")
	
func _execute(_delta): pass


func execute_components(delta):
	if COMPONENT_ARRAY_LEN < 0: return
	
	# Basically loops through and executes all the components within the state 
	# without using a for loop.
	component_id = component_id + 1 if component_id < COMPONENT_ARRAY_LEN - 1 else 0
	CurrentComponent = Components[component_id]
	
	if !CurrentComponent.has_method("_execute"): return
	if !CurrentComponent.can_execute: return
	CurrentComponent._execute(delta)

func update_execution_step():
	match execution_step:
		JUST_STARTED:
			emit_signal("state_entered")
			execution_step = EXECUTING
			

func exit():
	execution_step = JUST_STOPPED
	emit_signal("state_exited")
	

func _on_state_exited(): execution_step = JUST_STARTED
