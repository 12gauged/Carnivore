extends StatusBar

onready var RedFlashAnimPlayer: AnimationPlayer = $red_flash_anim_player




func set_status(value: int, animate: bool = true):
	var status_difference = value - last_status_value
	
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
	if stat_id in ["shields", "health"]:
		var dark_grey = Color(0.25, 0.25, 0.25, 1.0)
		IconContainer.modulate = dark_grey if stat_id == "shields" and new_value != 0 else Color.white
	
	if stat_id != tracked_stat_id: return
	set_status(new_value, animate)
