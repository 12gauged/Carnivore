extends CanvasLayer

onready var LogLabel: Label = $main_container/h_box_container/v_box_container/log

var max_log_size = 5
var repeated_log_count: int = 0
var last_log: String
var logs: Array = []



func _ready(): 
	LogLabel.visible = OS.is_debug_build()
	startup_logs()

func startup_logs():
	# this function exists because some scripts that used dprint function
	# call it before the node is initialized which causing an error, so i
	# call it here 
	dprint(game_data.get_current_platform())
	


func dprint(string: String):
	if !OS.is_debug_build(): return
	
	if len(logs) > max_log_size: logs.pop_front()
	
	if string != last_log:
		logs.append(string + "\n")
		repeated_log_count = 0
		last_log = string
	else:
		logs.pop_back()
		repeated_log_count += 1
		logs.append(last_log + "(%s)\n" % repeated_log_count)
	
	update_label_text()
	
func update_label_text():
	LogLabel.text = ""
	for dlog in logs:
		LogLabel.text += dlog
