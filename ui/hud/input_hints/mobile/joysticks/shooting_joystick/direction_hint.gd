extends Position2D


func _ready():
	input_events.connect("player_shooting_direction_updated", self, "_on_player_shooting_direction_updated")
	input_events.connect("player_shooting_joystick_pressed", self, "_on_player_shooting_joystick_pressed")
	input_events.connect("player_shooting_joystick_released", self, "_on_player_shooting_joystick_released")
	self.visible = false
	
func _on_player_shooting_direction_updated(value):
	look_at(self.global_position + value)
	
func _on_player_shooting_joystick_pressed(): self.visible = true
func _on_player_shooting_joystick_released(): self.visible = false
