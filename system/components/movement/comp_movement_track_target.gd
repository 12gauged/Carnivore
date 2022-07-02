extends Component

export(String) var target_node_group: String
export(bool) var flip_texture = false

var TextureToFlip: Sprite
var target_position: Vector2 setget set_target
var direction: Vector2

var Target

func _ready():
	Target = toolbox.get_node_in_group(target_node_group)
	ParentState.connect("state_exited", self, "stop_moving")

func _execute(_delta):
	if !is_instance_valid(Target): 
		emit_signal("component_value_update", Vector2.ZERO)
		return
	
	target_position = Target.global_position
	direction = self.global_position.direction_to(target_position)
	emit_signal("component_value_update", direction)
	
	if !flip_texture or !is_instance_valid(TextureToFlip): return
	TextureToFlip.flip_h = direction.x < 0
	
	
func set_target(value: Vector2):
	target_position = value
func stop_moving():
	emit_signal("component_value_update", Vector2.ZERO)
	
func set_texture_to_flip(texture_parent):
	TextureToFlip = texture_parent.get_texture()
