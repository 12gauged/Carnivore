extends Component

signal detected
export(String) var input_to_detect = ""
export(int) var number_of_inputs = 1

onready var InputDelayTimer: Timer = $input_delay
var input_count := 0
var detected: bool = false

func _input(event):
	if !can_execute: return
	
	match input_to_detect:
		"mouse_left": 
			if event is InputEventMouseButton: 
				if event.button_index == BUTTON_LEFT and event.is_pressed(): detected = true
		"mouse_right":
			if event is InputEventMouseButton and event.is_pressed(): 
				if event.button_index == BUTTON_RIGHT: detected = true
		"controls_shoot":
			if event is InputEventMouseButton: 
				var key_index = game_data.game_settings.desktop_keybinds.controls_shoot
				if event.button_index == key_index and event.is_pressed(): detected = true
		"controls_special":
			var key_index = game_data.game_settings.desktop_keybinds.controls_special
			if event is InputEventMouseButton and event.is_pressed(): 
				if event.button_index == key_index: detected = true
		_:
			if event.is_action_pressed(input_to_detect):
				detected = true
	
	InputDelayTimer.stop()
	
	input_count += 1
	if input_count >= number_of_inputs and detected:
		emit_signal("detected")
		detected = false
	
	InputDelayTimer.start()


func _on_input_delay_timeout():
	input_count = 0
