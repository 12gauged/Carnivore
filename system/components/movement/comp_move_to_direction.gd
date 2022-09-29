extends Component


var movement_direction := Vector2.LEFT

func _execute(_delta):
	emit_signal("component_value_update", movement_direction)
	
	
func set_movement_direction(value: Vector2):
	if value == Vector2.ZERO: return
	movement_direction = value
