extends TextureButton
class_name GenericButton

signal button_pressed(id)

export(String) var id = ""
const GRAY: Color = Color(0.5, 0.5, 0.5, 1.0)
const WHITE: Color = Color.white
onready var Child

func _ready():
	# warning-ignore:return_value_discarded
	connect("pressed", self, "_on_button_pressed")
	Child = set_child()
	check_if_disabled()
	
	
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
