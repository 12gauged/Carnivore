extends MarginContainer

export(String, "x", "y", "-x", "-y") var margin_axis = "x"
export(String) var assigned_setting_value = ""


func _ready():
	# warning-ignore:return_value_discarded
	connect("visibility_changed", self, "_on_visibility_changed")
	gui_events.connect("mobile_button_displacement_updated", self, "_on_displacement_updated")
	update_displacement(game_data.get_game_setting("mobile_button_displacement", assigned_setting_value))

		
func update_displacement(displacement):
	match margin_axis:
		"x": call_deferred("add_constant_override", "margin_left", displacement.x)
		"y": call_deferred("add_constant_override", "margin_top", displacement.y)
		"-x": call_deferred("add_constant_override", "margin_right", displacement.x)
		"-y": call_deferred("add_constant_override", "margin_bottom", displacement.y)
	game_data.set_game_setting("mobile_button_displacement", assigned_setting_value, displacement)
	
	
func _on_visibility_changed():
	var displacement = game_data.get_game_setting("mobile_button_displacement", assigned_setting_value)
	update_displacement(displacement)


func _on_displacement_updated(id, displacement):
	if id != assigned_setting_value: return
	update_displacement(displacement)
