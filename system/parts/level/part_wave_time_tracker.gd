extends Node

onready var TimeTracker: Timer = $timer
var time_passed: int = 0



func _ready():
	# warning-ignore:return_value_discarded
	game_events.connect("start_wave_time_tracker", self, "_on_start_wave_time_tracker_request")
	# warning-ignore:return_value_discarded
	game_events.connect("stop_wave_time_tracker", self, "_on_stop_wave_time_tracker_request")


func _on_timer_timeout(): 
	time_passed += 1
	game_events.emit_signal("wave_time_updated", time_passed)



func _on_start_wave_time_tracker_request(): TimeTracker.start()
func _on_stop_wave_time_tracker_request(): TimeTracker.stop()
