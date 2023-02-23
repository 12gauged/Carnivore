extends StatusBar

onready var RedFlashAnimPlayer: AnimationPlayer = $red_flash_anim_player



func _ready():
	var player_has_shields: bool = game_data.player_data.skills.hard_skin or game_data.player_data.skills.body_armor
	var dark_gray = Color(0.25, 0.25, 0.25, 1.0)
	self.modulate = dark_gray if player_has_shields else Color.white



func set_status(value: int, animate: bool = true):
	var status_difference = value - last_status_value
	
	if status_difference < 0: self.modulate = Color.white
	
	if value <= 2: RedFlashAnimPlayer.play("low_health_flash_loop")
	else: RedFlashAnimPlayer.play("RESET")
	
	if status_difference < 0:
		if value > 2: RedFlashAnimPlayer.play("flash")
		for i in range(abs(status_difference)):
			var icon_id = last_status_value - (i + 1)
			if animate: Icons[icon_id].play_empty_anim()
			else: Icons[icon_id].visible = false
			
	elif status_difference > 0:
		for i in range(status_difference):
			var icon_id = value - (i + 1)
			if animate: Icons[icon_id].play_fill_anim()
			else: Icons[icon_id].visible = true
		play_increase_sound()
		
	last_status_value = value
	
	
	
func _on_status_value_update(stat_id: String, new_value: int, animate: bool = true):
	if stat_id == "shields": if new_value <= 0: self.modulate = Color.white
	if stat_id != tracked_stat_id: return
	set_status(new_value, animate)
