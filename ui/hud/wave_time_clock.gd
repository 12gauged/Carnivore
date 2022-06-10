extends Label


const GRAY: Color = Color(0.25, 0.25, 0.25, 1.0)
const WHITE: Color = Color(1.0, 1.0, 1.0, 1.0)
var time_minutes: int = 0
var time_seconds: int = 0



func _ready():
	# warning-ignore:return_value_discarded
	game_events.connect("wave_time_updated", self, "_on_wave_time_updated")
	# warning-ignore:return_value_discarded
	game_events.connect("start_wave_time_tracker", self, "_on_wave_time_tracker_started")
	# warning-ignore:return_value_discarded
	game_events.connect("stop_wave_time_tracker", self, "_on_wave_time_tracker_stopped")
	
	
	
func _on_wave_time_updated(_value): 
	time_seconds += 1
	if time_seconds == 60:
		time_minutes += 1
		time_seconds = 0
	self.text = toolbox.convert_time_to_text(time_minutes, time_seconds)
	game_data.set_current_level_time([time_minutes, time_seconds])

func _on_wave_time_tracker_started(): self.modulate = WHITE
func _on_wave_time_tracker_stopped(): self.modulate = GRAY
