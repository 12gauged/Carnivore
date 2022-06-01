extends Component

export(bool) var reset
var target_position: Vector2

func _execute(_delta):
	if reset:
		Owner.get_texture().flip_v = false
		Owner.rotation_degrees = 0
		return
	look_at_target()

func look_at_target(): 
	Owner.look_at(target_position)
func set_target_position(value: Vector2):
	target_position = value
