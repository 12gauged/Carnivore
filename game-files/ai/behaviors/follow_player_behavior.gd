extends Behavior


@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("player")
@export var motion_handler: MotionHandler


func execute_physics(_delta) -> void:
	var parent_position: Vector2 = parent_node.get_global_position()
	var player_position: Vector2 = player.get_global_position()
	var direction_to_player: Vector2 = parent_position.direction_to(player_position)
	motion_handler.set_direction_vector(direction_to_player)
	
	
func stop_following() -> void:
	motion_handler.set_direction_vector(Vector2.ZERO)
	
