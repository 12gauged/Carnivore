extends Component

signal interacted

export(String) var input_action = ""
export(bool) var can_interact = true
export(Array) var TAGS = ["INTERACTABLE"]
export(Array) var ACCEPT_TAGS = ["PLAYER"]
export(Array) var IGNORE_TAGS = ["EAT"]
export(Dictionary) var method_to_execute = {"method": "", "caller": ""}

var DetectedArea



func _ready():
	set_process_input(false)

func _input(event):
	if event.is_action_pressed(input_action):
		interact(DetectedArea)



func tag_check_passed(body) -> bool:
	if !is_instance_valid(body): return false
	
	for tag in ACCEPT_TAGS:
		if !body.TAGS.has(tag): return false
		
	if body.TAGS.has("IGNORE"): return false
	
	for tag in IGNORE_TAGS:
		if body.TAGS.has(tag): return false
	
	return true

func interact(area):
	if !is_instance_valid(area): return
	
	if !"TAGS" in area:
		var area_owner = area.get_parent()
		if !tag_check_passed(area_owner): return
	else:
		if !tag_check_passed(area): return
	
	if method_to_execute.method != "": 
		toolbox.call_global_method(method_to_execute)
	emit_signal("interacted")
	
	if !input_action.empty():
		gui_events.emit_signal("hide_input_hint", "interact")
		
func disable_interactions(): can_interact = false
func enable_interactions(): can_interact = true



func _on_owner_area_entered(area):
	if !can_interact: return
	
	DetectedArea = area
	
	if input_action.empty():
		interact(area)
	else: 
		gui_events.emit_signal("show_input_hint", "interact")
		set_process_input(true)	
	
func _on_owner_area_exited(_area):
	set_process_input(!input_action.empty())
	gui_events.emit_signal("hide_input_hint", "interact")
	DetectedArea = null
