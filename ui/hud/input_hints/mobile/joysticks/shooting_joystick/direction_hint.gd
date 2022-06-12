extends Position2D


enum {
	FALSE,
	TRUE
}

var can_show: int = TRUE # GODOT DOESNT SUPPORT FUCKIN BOOL MULTIPLICATION ARGSGFSFASAF

func _ready():
	input_events.connect("player_shooting_direction_updated", self, "_on_player_shooting_direction_updated")
	input_events.connect("player_shooting_joystick_pressed", self, "_on_player_shooting_joystick_pressed")
	input_events.connect("player_shooting_joystick_released", self, "_on_player_shooting_joystick_released")
	player_events.connect("projectile_thrown", self, "_on_player_projectile_thrown")
	player_events.connect("projectile_collected", self, "_on_player_projectile_collected")
	self.visible = false
	
	
	
func _on_player_shooting_direction_updated(value):
	look_at(self.global_position + value)
	
func _on_player_shooting_joystick_pressed(): self.visible = bool(1 * can_show)
func _on_player_shooting_joystick_released(): self.visible = false

func _on_player_projectile_thrown(): 
	can_show = FALSE
	self.visible = false
func _on_player_projectile_collected(_projectile): 
	can_show = TRUE
