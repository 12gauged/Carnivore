extends HBoxContainer

onready var KeybindList := $list

onready var KeyLabel := $list/controls_up/button_medium/Label
onready var KeyFlashAnimation := $list/controls_up/AnimationPlayer

var current_action_to_assign := ""
var new_key_scancode := -1
	
func _ready():
	set_process_input(false)	

func _input(event):
	if event is InputEventKey:
		new_key_scancode = event.scancode
		KeyLabel.text = OS.get_scancode_string(new_key_scancode)
		update_keybind()
		KeyFlashAnimation.play("RESET")
	if event is InputEventMouseButton:
		pass
		
	

func update_keybind():
	set_process_input(false)
	
	apply_keybind(current_action_to_assign, new_key_scancode)
	game_data.game_settings.desktop_keybinds[current_action_to_assign] = new_key_scancode
	
	current_action_to_assign = ""
	new_key_scancode = -1	
		
func apply_keybind(action, scancode):
	var action_list = InputMap.get_action_list(action)
	if !action_list.empty(): InputMap.action_erase_event(action, action_list[0])
	var NewKey: InputEventKey = InputEventKey.new()
	NewKey.set_scancode(scancode)
	InputMap.action_add_event(action, NewKey)



func _on_controls_up_request_key_assignment(action):
	var keybind_dict = game_data.game_settings.desktop_keybinds
	
	current_action_to_assign = action
	
	KeyLabel.text = "_"
	KeyFlashAnimation.play("key_label_flash")

	set_process_input(true)
