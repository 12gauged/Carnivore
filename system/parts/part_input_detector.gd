extends Component

signal detected
export(String) var input_to_detect = ""

func _input(event):
	if !can_execute: return
	
	match input_to_detect:
		"mouse_left": 
			if event is InputEventMouseButton: 
				if event.button_index == BUTTON_LEFT and event.is_pressed(): emit_signal("detected")
		"mouse_right":
			if event is InputEventMouseButton and event.is_pressed(): 
				if event.button_index == BUTTON_RIGHT: emit_signal("detected")
		"controls_shoot":
			if event is InputEventMouseButton: 
				var key_index = game_data.game_settings.desktop_keybinds.controls_shoot
				if event.button_index == key_index and event.is_pressed(): emit_signal("detected")
		"controls_special":
			var key_index = game_data.game_settings.desktop_keybinds.controls_special
			if event is InputEventMouseButton and event.is_pressed(): 
				if event.button_index == key_index: emit_signal("detected")
		_:
			if event.is_action_pressed(input_to_detect):
				emit_signal("detected") 
