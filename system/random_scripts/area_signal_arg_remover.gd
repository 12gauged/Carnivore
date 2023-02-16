extends Area2D

signal area_detected
signal area_left
signal body_detected
signal body_left

func area_entered(_area): emit_signal("area_detected")
func body_entered(_body): emit_signal("body_detected")

func area_exited(_area): emit_signal("area_left")
func body_exited(_body): emit_signal("body_left")
