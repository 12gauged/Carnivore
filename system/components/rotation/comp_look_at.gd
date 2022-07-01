extends Component

var target_position: Vector2
var TargetNode

func _execute(_delta):
	look_at_target()

func look_at_target():
	if !is_instance_valid(TargetNode): return
	TargetNode.look_at(target_position)
func set_target_position(value: Vector2):
	target_position = value


func target_node_receiver(node):
	TargetNode = node
