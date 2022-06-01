extends Control
class_name InputHint

export(String) var id
export(String) var path_to_text_node = ""

var TextLabel: Label

func _ready(): 
	self.visible = false
	connect_signals()
	TextLabel = get_node(path_to_text_node)
	if is_instance_valid(TextLabel): TextLabel.text = id
	
func connect_signals():
	# warning-ignore:return_value_discarded
	gui_events.connect("show_input_hint", self, "_on_show_input_hint_request")
	# warning-ignore:return_value_discarded
	gui_events.connect("hide_input_hint", self, "_on_hide_input_hint_request")
	
func _on_show_input_hint_request(request_id):
	if request_id == id: self.visible = true
	
func _on_hide_input_hint_request(request_id):
	if request_id == id: self.visible = false
