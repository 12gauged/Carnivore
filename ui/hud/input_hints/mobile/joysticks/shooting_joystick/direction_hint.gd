extends Position2D


enum {
	FALSE,
	TRUE
}

var can_show: int = FALSE # GODOT DOESNT SUPPORT FUCKIN BOOL MULTIPLICATION ARGSGFSFASAF

func _ready():
	# warning-ignore:return_value_discarded
	input_events.connect("player_shooting_direction_updated", self, "_on_player_shooting_direction_updated")
	# warning-ignore:return_value_discarded
	input_events.connect("player_shooting_joystick_pressed", self, "_on_player_shooting_joystick_pressed")
	# warning-ignore:return_value_discarded
	input_events.connect("player_shooting_joystick_released", self, "_on_player_shooting_joystick_released")
	# warning-ignore:return_value_discarded
	player_events.connect("projectile_thrown", self, "_on_player_projectile_thrown")
	# warning-ignore:return_value_discarded
	player_events.connect("projectile_collected", self, "_on_player_projectile_collected")
	self.visible = false
	
	
	
func _on_player_shooting_direction_updated(value):
	look_at(self.global_position + value)
	
func _on_player_shooting_joystick_pressed(): 
	print("OI!")
	self.visible = bool(1 * can_show)
func _on_player_shooting_joystick_released(): self.visible = false#  ^
									 #                               |
func _on_player_projectile_thrown(): #                               |
	can_show = FALSE ## enum trickery for multiplication reasons ----|
	self.visible = false
func _on_player_projectile_collected(_projectile): 
	can_show = TRUE
