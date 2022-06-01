extends Node2D

signal detected
export(String) var input_to_detect = ""

func _input(event):
	match input_to_detect:
		"mouse_left": 
			if event is InputEventMouseButton: 
				if event.button_index == BUTTON_LEFT and event.is_pressed(): emit_signal("detected")
		"mouse_right":
			if event is InputEventMouseButton and event.is_pressed(): 
				if event.button_index == BUTTON_RIGHT: emit_signal("detected")
		_:
			if event.is_action_pressed(input_to_detect):
				emit_signal("detected") 
