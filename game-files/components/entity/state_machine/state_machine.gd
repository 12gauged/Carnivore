extends Node2D


signal started()
signal state_changed(new_state)
var states: Array[State]
var current_state: State
var current_state_id: int = 0


func _ready() -> void:
	states = get_available_states()
	
	
func get_available_states() -> Array[State]:
	var result: Array[State]
	for child in get_children():
		if not child is State:
			continue
		result.append(child)
	return result
	
	
func set_current_state(state: State) -> void:
	current_state = state
	current_state.enter_state()
	state_changed.emit(current_state.name.to_snake_case())
	
	
func start() -> void:
	set_current_state(states[current_state_id])
	started.emit()
	
	
func move_to_next_state() -> void:
	if current_state:
		current_state.leave_state()
	
	# Swaps to new state
	current_state_id = (current_state_id + 1) % len(states)
	set_current_state(states[current_state_id])
	
	print_debug("current_state_id = %s\ncurrent_state.name = %s\n" % [current_state_id, current_state.name])
	
