extends DetectionBox

signal hit_detected(Hitbox)


func play_hit_sound(area):
	if !is_instance_valid($hit_sound_effect): return
	if !"damage" in area and !area.damage > 0: return
	if Owner is Entity and "invincible" in Owner.stats and Owner.stats.invincible: return
	$hit_sound_effect.play()



func _on_part_hurtbox_area_entered(area):
	if !area is DetectionBox: return
	
	for tag in area.TAGS:
		if tag in IGNORE_TAGS:
			return
			
	play_hit_sound(area)
	emit_signal("hit_detected", area)
