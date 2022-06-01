extends Component

onready var AnimPlayer = get_node("animation_player")

export(Array) var states
var current_state: String = states[0] if !states.empty() else ""

func _process(_delta):
	play_state_animation()
	
func set_state(value: String, _old_state):
	current_state = value
	
func play_state_animation():
	if !is_instance_valid(AnimPlayer) or current_state.empty(): return
	AnimPlayer.play(current_state)
