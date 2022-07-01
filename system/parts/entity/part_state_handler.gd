extends Component

signal go_to_next_state_request
signal start_state_pattern_request


var state_executers: Dictionary = {}
var existing_state_nodes: Array = []
var current_state: String = ""



func _ready():
	for state in get_children():
		state_executers[state.name] = state
		existing_state_nodes.append(state.name)

func _process(delta):
	if current_state.empty(): return
	
	if state_executers.has(current_state):
		state_executers[current_state]._state_execute(delta)
	elif "*" in existing_state_nodes:
		state_executers["*"]._state_execute(delta)
		
	
	
func go_to_next_state(): emit_signal("go_to_next_state_request")
func start_state_pattern(): emit_signal("start_state_pattern_request")



func _on_state_changed(new_state, old_state):
	current_state = new_state
	if state_executers.has(old_state):
		state_executers[old_state].exit()
