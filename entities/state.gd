extends Node2D
class_name State

signal state_entered
signal executing
signal state_exited

var Components: Array = []
var component_id: int = -1
var execution_step: int = 0
enum {
	JUST_STARTED,
	EXECUTING,
	JUST_STOPPED
}


func _ready():
	# warning-ignore:return_value_discarded
	connect("state_entered", self, "_on_state_entered")
	# warning-ignore:return_value_discarded
	connect("state_exited", self, "_on_state_exited")
	Components = get_children()

func _state_execute(delta):
	update_execution_step()
	execute_components(delta)
	_execute(delta)
	emit_signal("executing")
	
func _execute(_delta): pass


func execute_components(delta):
	# Basically loops through and executes all the components within the state 
	# without using a for loop.
	component_id = component_id + 1 if component_id < len(Components) - 1 else 0
	var CurrentComponent = Components[component_id]
	if CurrentComponent.has_method("_execute"):
		CurrentComponent._execute(delta)

func update_execution_step():
	match execution_step:
		JUST_STARTED:
			emit_signal("state_entered")
			execution_step = EXECUTING
			

func exit():
	execution_step = JUST_STOPPED
	emit_signal("state_exited")


func _on_state_entered():
	for component in get_children():
		if component is Timer and component.is_stopped():
			component.start()
		if component is DetectionBox and component.Collision.disabled:
			component._enable_request()

func _on_state_exited():
	execution_step = JUST_STARTED
	for component in get_children():
		if component is DetectionBox and component.Collision.disabled:
			component._disable_request()
