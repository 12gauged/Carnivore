extends DetectionBox

signal hit_detected(Hitbox)

func _on_part_hurtbox_area_entered(area):
	if !area is DetectionBox: return
	if !is_area_valid(area): return
	emit_signal("hit_detected", area)
