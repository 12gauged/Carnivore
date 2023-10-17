extends Node


@export_enum("ui_events", "hud_events") var event_type: String = "ui_events"
@export var event_name: String
@export var args: Array
@onready var event_singletons: Dictionary = {
	"ui_events": UIEvents,
	"hud_events": HUDEvents
}


func emit() -> void:
	var singleton: Node = event_singletons[event_type]
	
	if not event_name in singleton:
		push_error("%s doesn't have signal %s" % [singleton.name, event_name])
		return
	
	singleton.get(event_name).emit(args)
	
	
func set_arg(value, arg_index: int = 0) -> void:
	args[arg_index] = value
