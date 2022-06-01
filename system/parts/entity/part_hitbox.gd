extends DetectionBox

signal hit_detected(Hurtbox)

export(int) var damage

func _on_part_hitbox_area_entered(area):
	if !area is DetectionBox: return
	for tag in area.TAGS:
		if tag in IGNORE_TAGS: return
	
	emit_signal("hit_detected", area)
