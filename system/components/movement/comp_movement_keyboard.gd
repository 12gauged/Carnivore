extends Component

var input_vector: Vector2 = Vector2.ZERO
var input_strengths: Dictionary = {
	"left": 0.0, "right": 0.0, "up": 0.0, "down": 0.0
}
	
func _execute(_delta):
	input_strengths.left = Input.get_action_strength("controls_left")
	input_strengths.right = Input.get_action_strength("controls_right")
	input_strengths.up = Input.get_action_strength("controls_up")
	input_strengths.down = Input.get_action_strength("controls_down")
	
	input_vector.x = input_strengths.right - input_strengths.left
	input_vector.y = input_strengths.down - input_strengths.up
	input_vector = input_vector.normalized()
	
	emit_signal("component_value_update", input_vector)
	input_events.emit_signal("player_movement_direction_updated", input_vector)
