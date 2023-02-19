extends StatusBar

onready var RedFlashAnimPlayer = $red_flash_anim_player

func set_status(value: int, animate: bool = true):
	var status_difference = value - last_status_value
	
	if status_difference < 0:
		if animate: RedFlashAnimPlayer.play("flash")
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
