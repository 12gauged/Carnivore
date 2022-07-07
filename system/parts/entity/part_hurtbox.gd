extends DetectionBox

signal hit_detected(Hitbox)
signal play_hit_sound_request()

onready var HitSoundEffect = $hit_sound_effect


func _ready(): 
	# warning-ignore:return_value_discarded
	connect("play_hit_sound_request", HitSoundEffect, "play")
	

func _on_part_hurtbox_area_entered(area):
	if !area is DetectionBox: return
	if !is_area_valid(area): return
			
	emit_signal("play_hit_sound_request")
	emit_signal("hit_detected", area)
