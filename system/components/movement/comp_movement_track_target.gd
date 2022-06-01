extends Component

export(bool) var flip_texture = false

var target_position: Vector2 setget set_target
var direction: Vector2

var Target

func _ready():
	ParentState.connect("state_exited", self, "stop_moving")

func _execute(_delta):
	Target = Owner.AI_TARGET
	
	if !is_instance_valid(Target): 
		emit_signal("component_value_update", Vector2.ZERO)
		return
	
	target_position = Owner.AI_TARGET.global_position
	direction = Owner.global_position.direction_to(target_position)
	emit_signal("component_value_update", direction)
	
	if !flip_texture: return
	Owner.get_texture().flip_h = direction.x < 0
	
	
func set_target(value: Vector2):
	target_position = value
func stop_moving():
	emit_signal("component_value_update", Vector2.ZERO)
