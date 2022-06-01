extends Label


const GRAY: Color = Color(0.25, 0.25, 0.25, 1.0)
const WHITE: Color = Color(1.0, 1.0, 1.0, 1.0)
var time_minutes: int = 0
var time_seconds: int = 0



func _ready():
	# warning-ignore:return_value_discarded
	game_events.connect("arena_ended", self, "_on_arena_ended")
	# warning-ignore:return_value_discarded
	game_events.connect("wave_time_updated", self, "_on_wave_time_updated")
	# warning-ignore:return_value_discarded
	game_events.connect("start_wave_time_tracker", self, "_on_wave_time_tracker_started")
	# warning-ignore:return_value_discarded
	game_events.connect("stop_wave_time_tracker", self, "_on_wave_time_tracker_stopped")
	
	
	
func get_time_string(minutes, seconds) -> String:
	var base_string = "%s:%s"
	var result

	if minutes < 10 and seconds < 10: base_string = "0%s:0%s"
	elif minutes >= 10 and seconds < 10: base_string = "%s:0%s"
	elif minutes >= 10 and seconds >= 10: base_string = "%s:%s"
	elif minutes < 10 and seconds >= 10: base_string = "0%s:%s"
	
	result = base_string % [time_minutes, time_seconds]
	return result
	
	
	
func _on_wave_time_updated(_value): 
	time_seconds += 1
	if time_seconds == 60:
		time_minutes += 1
		time_seconds = 0
	self.text = get_time_string(time_minutes, time_seconds)

func _on_wave_time_tracker_started(): self.modulate = WHITE
func _on_wave_time_tracker_stopped(): self.modulate = GRAY



func _on_arena_ended(): game_data.set_player_data("lowest_time", self.text)
