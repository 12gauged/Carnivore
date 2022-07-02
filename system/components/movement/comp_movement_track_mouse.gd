extends Component

var target: Vector2
var direction: Vector2

func _execute(_delta):
	target = get_global_mouse_position()
	direction = self.global_position.direction_to(target)
	emit_signal("component_value_update", direction)
	
func stop_moving():
	emit_signal("component_value_update", Vector2.ZERO)
