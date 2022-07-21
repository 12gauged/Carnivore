extends TextureButton
class_name GenericButton

signal button_pressed(id)

export(String) var id = ""
const GRAY: Color = Color(0.5, 0.5, 0.5, 1.0)
onready var Child

func _ready():
	# warning-ignore:return_value_discarded
	connect("pressed", self, "_on_button_pressed")
	Child = set_child()
	if !is_instance_valid(Child): return
	if self.disabled: Child.modulate = GRAY
	
	
func set_child(): return null
func _on_button_pressed(): emit_signal("button_pressed", id)
