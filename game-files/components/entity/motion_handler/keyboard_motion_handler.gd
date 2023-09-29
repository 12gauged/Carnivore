extends MotionHandler


@export var action_up: String = "action_up"
@export var action_down: String = "action_down"
@export var action_left: String = "action_left"
@export var action_right: String = "action_right"


func update_direction_vector() -> void:
	var direction: Vector2 = Input.get_vector(
		action_left, 
		action_right, 
		action_up, 
		action_down
	)
	direction = direction.normalized()
	set_direction_vector(direction)
