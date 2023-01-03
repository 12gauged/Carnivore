extends HBoxContainer

onready var KeybindList := $list

const MOUSE_ACTIONS = ["action_shoot", "action_special"]

var current_action_to_assign := ""
var current_input_type := ""
var new_key_scancode := -1
var selected_button
var unavailable_keybinds = {}
var mouse_looking_for_input = false
	
	
	
func _ready():
	set_process_input(false)
	update_unavailable_keybinds()
	
func _input(event):
	match current_input_type:
		"mouse": process_mouse_input(event)
		"key": process_key_input(event)
		
func process_key_input(event):
	if event is InputEventKey:
		if event.is_action_pressed("ui_cancel"):
			var keybind_dict = game_data.game_settings.desktop_keybinds
			selected_button.stop_flashing()
			selected_button.set_text(OS.get_scancode_string(keybind_dict[current_action_to_assign]))
			set_process_input(false)
			return
			
		new_key_scancode = event.scancode
		var new_button_string = OS.get_scancode_string(new_key_scancode)
		
		if new_button_string in unavailable_keybinds.keys():
			var action_to_override = unavailable_keybinds[new_button_string]
			apply_keybind(action_to_override, null)
			get_node("list/%s" % action_to_override).set_text("")
			game_data.game_settings.desktop_keybinds[action_to_override] = null
		
		selected_button.set_text(new_button_string)
		update_keybind()
		update_unavailable_keybinds()
		selected_button.stop_flashing()
		
		
func process_mouse_input(event):
	if event is InputEventKey:
		if event.is_action_pressed("ui_return"):
			var keybind_dict = game_data.game_settings.desktop_keybinds
			selected_button.stop_flashing()
			selected_button.enable()
			selected_button.set_texture(keybind_dict[current_action_to_assign])
			set_process_input(false)
			return
	if event is InputEventMouseButton:
		if mouse_looking_for_input:
			selected_button.enable()
			mouse_looking_for_input = false		
			set_process_input(false)
			return
			
		selected_button.stop_flashing()
		var button_index = event.button_index
		selected_button.set_texture(button_index)
		game_data.game_settings.desktop_keybinds[current_action_to_assign] = button_index
		mouse_looking_for_input = true
	
	

func update_keybind():
	set_process_input(false)
	apply_keybind(current_action_to_assign, new_key_scancode)
	game_data.game_settings.desktop_keybinds[current_action_to_assign] = new_key_scancode
	current_action_to_assign = ""
	new_key_scancode = -1	
		
func apply_keybind(action, scancode):
	var action_list = InputMap.get_action_list(action)
	if !action_list.empty(): InputMap.action_erase_event(action, action_list[0])
	if scancode == null: return
	var NewKey: InputEventKey = InputEventKey.new()
	NewKey.set_scancode(scancode)
	InputMap.action_add_event(action, NewKey)
	
func update_unavailable_keybinds():
	unavailable_keybinds = {}
	var keybind_dict = game_data.game_settings.desktop_keybinds
	for action in keybind_dict:
		if keybind_dict[action] != null and not action in MOUSE_ACTIONS:
			var action_key = OS.get_scancode_string(keybind_dict[action])
			unavailable_keybinds[action_key] = action



func _on_request_key_assignment(action, requester, type):
	if is_instance_valid(selected_button): 
		selected_button.stop_flashing()
		if type == "mouse" and selected_button.has_method("enable"): selected_button.enable()
	
	current_action_to_assign = action
	selected_button = requester
	current_input_type = type
	selected_button.start_flashing()
	set_process_input(true)
	
	if type == "mouse": selected_button.disable()
