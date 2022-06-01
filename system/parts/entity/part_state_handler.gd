extends Component

var state_executers: Dictionary = {}
var existing_state_nodes: Array = []
var current_state: String = ""


func _ready():
	Owner.connect("state_changed", self, "_on_state_changed")
	for state in get_children():
		state_executers[state.name] = state
		existing_state_nodes.append(state.name)

func _process(delta):
	if current_state.empty(): return
	
	if state_executers.has(current_state):
		state_executers[current_state]._state_execute(delta)
	elif "*" in existing_state_nodes:
		state_executers["*"]._state_execute(delta)
		
	
	
func go_to_next_state(): 
	Owner.go_to_next_state()
func start_state_pattern(): Owner.start_state_pattern()



func _on_state_changed(new_state, old_state):
	current_state = new_state
	if state_executers.has(old_state):
		state_executers[old_state].exit()
