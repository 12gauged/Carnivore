extends CanvasLayer

onready var LogLabel: Label = $main_container/h_box_container/v_box_container/log

var max_log_size = 5
var repeated_log_count: int = 0
var last_log: String
var logs: Array = []



func _input(event):
	if event.is_action_pressed("debug_f5"): clear_log()


func _ready(): 
	LogLabel.visible = OS.is_debug_build()
	startup_logs()



func startup_logs():
	# this function exists because some scripts that used dprint function
	# call it before the node is initialized which causing an error, so i
	# call it here
	
	dprint("")
	#dprint(game_data.get_current_platform())
	pass

func clear_log():
	logs = []
	last_log = ""
	update_label_text()

func dprint(string: String, dict_formatting: bool = false):
	if !OS.is_debug_build(): return
	
	if len(logs) > max_log_size: logs.pop_front()
	
	if string != last_log:
		logs.append(string_as_dict(string, dict_formatting) + "\n")
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
		
		
func string_as_dict(text: String, dict_formatting: bool = false) -> String:
	if !dict_formatting: return text
	
	var TAB_SIZE = "    "
	var result: String
	var indentation = ""
	
	for c in text:
		if c == "{": indentation += TAB_SIZE
		if c == "}": indentation.replace(TAB_SIZE, "")
		
		if c in [",", "{", "}"]: result += indentation + c + "\n"
		else: result += c
	
	return result
