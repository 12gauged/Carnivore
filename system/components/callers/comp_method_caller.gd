extends Node2D

signal method_called
export(Dictionary) var method = {"caller": "", "method": ""}

func call_method():
	toolbox.call_global_method(method)
	emit_signal("method_called")
