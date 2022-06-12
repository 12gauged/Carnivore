extends Label

# warning-ignore:unused_signal
signal best_time_reached

func _ready():
	var level_time: Array = game_data.get_current_level_time()
	var last_lowest_time: Array = game_data.get_last_lowest_level_time()
	
	if last_lowest_time.empty(): return
	
	var minutes: int = level_time[0]
	var seconds: int = level_time[1]
	self.text = toolbox.convert_time_to_text(minutes, seconds)
	
	var lowest_time_in_seconds = toolbox.minutes_to_seconds(last_lowest_time[0], last_lowest_time[1])
	var current_time_in_seconds = toolbox.minutes_to_seconds(level_time[0], level_time[1])
	
	print("lowest time: %s\ncurrent_time: %s\n" % [lowest_time_in_seconds, current_time_in_seconds])
	if lowest_time_in_seconds > current_time_in_seconds:
		call_deferred("emit_signal", "best_time_reached")
