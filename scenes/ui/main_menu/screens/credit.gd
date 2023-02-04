extends Label

signal credit_pressed(btn_id)

export(String) var credit_id
onready var Btn = $TextureButton

func _ready():
	Btn.connect("pressed", self, "_on_button_pressed")
	# warning-ignore:return_value_discarded
	Btn.connect("mouse_entered", self, "_on_mouse_entered")
	# warning-ignore:return_value_discarded
	Btn.connect("mouse_exited", self, "_on_mouse_exited")
	
func _on_button_pressed():
	emit_signal("credit_pressed", credit_id)

func _on_mouse_entered(): self.modulate = Color.yellow
func _on_mouse_exited(): self.modulate = Color.white
