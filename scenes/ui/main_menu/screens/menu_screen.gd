extends Control
class_name MenuScreen

signal button_pressed(id)
func _on_button_pressed(id): emit_signal("button_pressed", id)
