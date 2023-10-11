extends Node


signal action_pressed
@export var action_name: String


func _unhandled_input(event):
	if event.is_action_pressed(action_name):
		action_pressed.emit()
