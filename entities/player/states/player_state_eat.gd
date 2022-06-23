extends State

onready var CompLookAt: Component = $comp_look_at

var texture = Sprite
var target: Vector2 = Vector2.ZERO

onready var StateMachine: Node2D = get_parent()


func _ready():
	# warning-ignore:return_value_discarded
	input_events.connect("player_movement_direction_updated", self, "_on_player_direction_updated")

func _execute(_delta):
	texture = StateMachine.Owner.get_texture()
	
	match game_data.get_current_platform():
		"desktop": 
			target = get_global_mouse_position()
			texture.flip_v = target.x < StateMachine.Owner.global_position.x
		"mobile":
			texture.flip_v = target.x < StateMachine.Owner.global_position.x
			texture.flip_h = true
		
	
	CompLookAt.set_target_position(target)
	
	
func _on_player_direction_updated(value):
	target = global_position + value
	
func _on_state_exited():
	texture.flip_h = false
	texture.flip_v = false
