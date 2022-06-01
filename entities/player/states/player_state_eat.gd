extends State

onready var CompLookAt: Component = $comp_look_at

var mouse_position: Vector2
var texture = Sprite

onready var StateMachine: Node2D = get_parent()

func _execute(_delta):
	mouse_position = get_global_mouse_position()
	CompLookAt.set_target_position(mouse_position)
	
	texture = StateMachine.Owner.get_texture()
	texture.flip_v = mouse_position.x < StateMachine.Owner.global_position.x
	
