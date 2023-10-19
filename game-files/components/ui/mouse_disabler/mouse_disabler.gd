extends Control


func disable() -> void:
	set_mouse_filter(Control.MOUSE_FILTER_STOP)


func enable() -> void:
	set_mouse_filter(Control.MOUSE_FILTER_IGNORE)
