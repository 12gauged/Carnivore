extends TextureButton
class_name GenericButton

signal button_pressed(id)
signal button_toggled(id, btn_pressed)

export(String) var id = ""
export(bool) var toggle = false
const GRAY: Color = Color(0.5, 0.5, 0.5, 1.0)
const WHITE: Color = Color.white
onready var Child

func _ready():
	Child = set_child()
	check_if_disabled()
	if toggle:
		# warning-ignore:return_value_discarded
		connect("toggled", self, "_on_button_toggled")
		return
	# warning-ignore:return_value_discarded
	connect("pressed", self, "_on_button_pressed")
	
	
func set_child(): return null

func check_if_disabled():
	if !is_instance_valid(Child): return
	if self.disabled: Child.modulate = GRAY
	else: Child.modulate = WHITE
	
func disable():
	self.disabled = true
	check_if_disabled()
func enable():
	self.disabled = false
	check_if_disabled()


func _on_button_pressed(): emit_signal("button_pressed", id)
func _on_button_toggled(btn_pressed): emit_signal("button_toggled", id, btn_pressed) 
