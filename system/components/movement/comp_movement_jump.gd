extends Component

signal jump_finished

const GRAVITY: int = 20

export(String) var target_node_group: String
export(int) var jump_force = 90
export(int) var jump_height = 10
export(int) var jump_speed_multiplier = 1
export(int) var jump_distance_limit = 0
export(bool) var use_projectile_motion = false


var Target

var jump_position: Vector2
var target_position: Vector2 setget set_target
var direction: Vector2
var force: float = 0



var target_pos : Vector2

var elapsed_time : float
var time_to_target: float
var velocity : float
var launch_angle : float
var launch_direction: Vector2

var jump_initial_pos: Vector2
var jump_final_pos: Vector2


func _ready():
	Target = toolbox.get_node_in_group(target_node_group)
	can_execute = false


func _execute(delta):
	projectile_motion(delta)

	
func start_jump():
	Owner.disable_collision()
	
	jump_initial_pos = Owner.global_position
	target_pos = Target.global_position - jump_initial_pos
	
	if jump_distance_limit > 0:
		target_pos.x = clamp(abs(target_pos.x), 0.0, jump_distance_limit) * (target_pos.x / abs(target_pos.x))
		target_pos.y = clamp(abs(target_pos.y), 0.0, jump_distance_limit) * (target_pos.y / abs(target_pos.y))
	
	launch_direction = Vector2.RIGHT if target_pos.x > 0 else Vector2.LEFT
	
	target_pos.x = abs(target_pos.x)
	target_pos.y *= -1
	
	velocity = sqrt(GRAVITY * (target_pos.y + sqrt(pow(target_pos.y, 2) + pow(target_pos.x, 2))))
	launch_angle = atan(target_pos.y / target_pos.x + sqrt(pow(target_pos.y, 2) / pow(target_pos.x, 2) + 1))
	time_to_target = target_pos.x / (velocity * cos(launch_angle))
	
	can_execute = true
	
func projectile_motion(delta):
	if elapsed_time >= time_to_target:
		emit_signal("component_value_update", Vector2.ZERO)
		emit_signal("jump_finished")
		Owner.enable_collision()
		
		elapsed_time = 0.0
		can_execute = false
		return
	
	elapsed_time += delta * 5 # corrects the delta value
	
	var displacement_x = velocity * elapsed_time * cos(launch_angle)
	var displacement_y = velocity * elapsed_time * sin(launch_angle) - 0.5 * GRAVITY * pow(elapsed_time, 2)
	
	displacement_x = displacement_x if launch_direction == Vector2.RIGHT else displacement_x * -1
	displacement_y = displacement_y * -1.0
	
	var owner_position = Owner.global_position
	var direction_vector = owner_position.direction_to(jump_initial_pos + Vector2(displacement_x, displacement_y))
	emit_signal("component_value_update", direction_vector)
	
	
func set_target(value: Vector2):
	target_position = value
func stop_moving():
	emit_signal("component_value_update", Vector2.ZERO)
