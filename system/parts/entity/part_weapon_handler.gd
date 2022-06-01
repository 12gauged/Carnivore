extends Component

onready var CompLookAt: Node = $pivot/comp_look_at

func set_target_position(value: Vector2):
	CompLookAt.set_target_position(value)
