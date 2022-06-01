extends Control

onready var LabelNode: Label = $center_container/texture/label_container/label
var text_id: int = 0
var texts


func _input(event):
	if event.is_action_pressed("ui_accept"):
		text_id += 1
		
		match typeof(texts):
			TYPE_STRING:
				hide_text_box()
				return
			TYPE_ARRAY:
				if text_id > len(texts) - 1: 
					hide_text_box()
					return
		
		LabelNode.text = texts[text_id]

func _ready():
	# warning-ignore:return_value_discarded
	gui_events.connect("text_box_request", self, "_on_text_box_requested")
	set_process_input(false)	
	self.visible = false
	
	
	
func hide_text_box():
	self.visible = false
	set_process_input(false)
	gui_events.emit_signal("show_hud")
	gui_events.emit_signal("text_box_skipped")
	
func show_text_box():
	self.visible = true
	set_process_input(true)
	gui_events.emit_signal("hide_hud")
	
	
	
func _on_text_box_requested(received_texts):
	if received_texts.empty() or received_texts == null: return
	
	texts = received_texts
	
	match typeof(texts):
		TYPE_ARRAY:
			text_id = 0
			LabelNode.text = texts[text_id]
		TYPE_STRING:
			LabelNode.text = texts
	
	show_text_box()
