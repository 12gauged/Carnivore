extends Node


signal vector_updated(value: Vector2)
@export var action_left: String = ""
@export var action_right: String = ""
@export var action_up: String = ""
@export var action_down: String = ""
var vector: Vector2 = Vector2.ZERO


func _process(_delta) -> void:
	vector = Input.get_vector(action_left, action_right, action_up, action_down)
	vector_updated.emit(vector)
