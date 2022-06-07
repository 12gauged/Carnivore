extends Component

signal jump_finished

const JUMP_HEIGHT: int = 6
const GRAVITY: int = 8

export(int) var jump_force = 80

var Target

var jump_position: Vector2
var target_position: Vector2 setget set_target
var direction: Vector2
var force: int = 0



func _execute(_delta):
	
	# DON'T TOUCH THIS FUCKING CODE FELIPE ISTG
	# IF YOU TOUCH IT I'M GOING TO REVOKE YOUR
	# COCK PERMISSIONS
	#               - past felipe
	
	# just touched this.
	# my cock has been revoked.
	#				- present felipe
	
	if !is_instance_valid(Target): 
		emit_signal("component_value_update", Vector2.ZERO)
		return
	
	jump_position.y += GRAVITY
	force -= 4
	
	if force <= 0:
		emit_signal("component_value_update", Vector2.ZERO)
		emit_signal("jump_finished")
		Owner.enable_collision()
		return
	
	emit_signal("component_value_update", Owner.global_position.direction_to(jump_position))
	
	
	
func start_jump():
	Owner.disable_collision()
	
	Target = Owner.AI_TARGET
	target_position = Target.global_position
	
	var distance_to_target = Owner.global_position.distance_to(target_position)
	print(distance_to_target)
	force = distance_to_target * 0.5 if distance_to_target > 100 else distance_to_target
	
	jump_position = Vector2(
		Owner.global_position.x + Owner.global_position.direction_to(target_position).x * jump_force,
		Owner.global_position.y + Owner.global_position.direction_to(target_position).y * jump_force - force
	)
	
func set_target(value: Vector2):
	target_position = value
func stop_moving():
	emit_signal("component_value_update", Vector2.ZERO)
