extends Control

signal exited_layout_editor


var SelectedButton
var new_chosen_position := Vector2.ZERO

var changes = {}

var previous_control_layout = game_data.game_settings.mobile_button_displacement.duplicate()

func _input(event):
	if !is_instance_valid(SelectedButton): return
	
	if event is InputEventScreenTouch:
		
		if !event.is_pressed():
			change_button_color(SelectedButton, Color.white)
			SelectedButton = null
			return
			
	new_chosen_position = event.position
	
	# corrects the positioning to the margings
	var WINDOW_SIZE := get_viewport_rect().size
	var margin_x_axis = SelectedButton.get_margin_axis()[0]
	var margin_y_axis = SelectedButton.get_margin_axis()[1]
	if margin_x_axis == "-x": 
		new_chosen_position.x -= WINDOW_SIZE.x
		new_chosen_position.x = abs(new_chosen_position.x)
	if margin_y_axis == "-y": 
		new_chosen_position.y -= WINDOW_SIZE.y
		new_chosen_position.y = abs(new_chosen_position.y)

	changes[SelectedButton.get_margin_assigned_setting_key()[0]] = new_chosen_position
	SelectedButton.set_margins(new_chosen_position)
	print("setting margins for: ", SelectedButton.name)
	



func change_button_color(button, color):
	button.material.set_shader_param("color", color)
	
func return_to_settings_screen():
	emit_signal("exited_layout_editor")
	
	

func _on_button_pressed(button):
	if is_instance_valid(SelectedButton): change_button_color(SelectedButton, Color.white)
	change_button_color(button, Color.yellow)
	SelectedButton = button


func _on_exit_without_saving_button_pressed(_id):
	game_data.game_settings.mobile_button_displacement = previous_control_layout.duplicate()
	return_to_settings_screen()


func _on_exit_and_save_button_pressed(_id):
	for change in changes.keys():	
		gui_events.emit_signal("mobile_button_displacement_updated", change, changes[change])
	previous_control_layout = game_data.game_settings.mobile_button_displacement.duplicate()
	global_data_manager.save_settings()
	return_to_settings_screen()
	

func _on_reset_button_pressed(_id):
	changes = {}
	var button_positions: Dictionary = game_data.default_game_settings.mobile_button_displacement.duplicate()
	for button in button_positions.keys():	
		gui_events.emit_signal("mobile_button_displacement_updated", button, button_positions[button])
	
	
	
	
	
	
	
	
	
	
	
	
