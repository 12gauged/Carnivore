extends Node

onready var TimeTracker: Timer = $timer
var time_passed: int = 0



func _ready():
	# warning-ignore:return_value_discarded
	game_events.connect("arena_ended", self, "_on_arena_ended")
	# warning-ignore:return_value_discarded
	game_events.connect("start_wave_time_tracker", self, "_on_start_wave_time_tracker_request")
	# warning-ignore:return_value_discarded
	game_events.connect("stop_wave_time_tracker", self, "_on_stop_wave_time_tracker_request")



func save_last_lowest_time(placeholder_time):
	var last_lowest_time = game_data.get_player_data("lowest_time")
	if last_lowest_time.empty(): 
		game_data.set_last_lowest_level_time(placeholder_time)
		return
	game_data.set_last_lowest_level_time(last_lowest_time)


func _on_timer_timeout(): 
	time_passed += 1
	game_events.emit_signal("wave_time_updated", time_passed)

func _on_start_wave_time_tracker_request(): TimeTracker.start()
func _on_stop_wave_time_tracker_request(): TimeTracker.stop()

func _on_arena_ended():
	var lowest_time = game_data.get_player_data("lowest_time")
	var level_time = game_data.get_current_level_time()
	
	if lowest_time.empty():
		game_data.set_player_data("lowest_time", level_time)
		return
	
	var full_time_in_seconds = toolbox.minutes_to_seconds(level_time[0], level_time[1])
	var lowest_time_in_seconds = toolbox.minutes_to_seconds(lowest_time[0], lowest_time[1])
	
	if lowest_time_in_seconds > full_time_in_seconds: # New record
		save_last_lowest_time(level_time)
		game_data.set_player_data("lowest_time", level_time)
