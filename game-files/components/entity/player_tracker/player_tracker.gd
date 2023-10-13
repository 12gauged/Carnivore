extends Node
class_name PlayerTracker


signal player_position_updated(position)
signal direction_to_player_updated(direction)
@export var parent: Node2D
@export var player_group_name: String = "player"
var player_position: Vector2
var direction_to_player: Vector2
@onready var player = get_tree().get_first_node_in_group("player")


func _process(delta):
	if not is_instance_valid(player):
		return
	
	player_position = player.get_global_position()
	player_position_updated.emit(player_position)
	
	if not is_instance_valid(parent):
		return
		
	direction_to_player = parent.global_position.direction_to(player_position)
	direction_to_player_updated.emit(direction_to_player)
	
