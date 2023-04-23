extends Control
class_name StatusBar

const SPRITE_WIDTH = 8

export(String) var tracked_stat_id 

onready var IconContainer: GridContainer = $empty_bar/icons
var Icons: Array = []
var last_status_value: int



func _ready():
	# warning-ignore:return_value_discarded
	player_events.connect("status_value_update", self, "_on_status_value_update")
	Icons = IconContainer.get_children()
	last_status_value = get_first_status_value()



func get_first_status_value() -> int: return len(Icons)
func play_increase_sound(): if is_instance_valid(get_node("increase_sound_effect")): $increase_sound_effect.play()
func play_full_sound(): if is_instance_valid(get_node("full_sound_effect")): $full_sound_effect.play()

func set_status(value: int, animate: bool = true):
	var status_difference = value - last_status_value
	
	if status_difference < 0:
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
	if stat_id != tracked_stat_id: return
	set_status(new_value, animate)
