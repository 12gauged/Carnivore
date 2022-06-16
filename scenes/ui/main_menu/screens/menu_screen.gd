extends Control
class_name MenuScreen

signal button_pressed(id)
func _on_button_pressed(id): 
	print("emitting!\nid:%s\n" % id)
	emit_signal("button_pressed", id)
