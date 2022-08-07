extends Node2D

export(String) var caller = ""
export(String) var event = ""

func call_event():
	toolbox.callers[caller].emit_signal(event)
