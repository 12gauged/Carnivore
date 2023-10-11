extends Node


@export_enum("ui_events") var event_type: String = "ui_events"
@export var event_name: String
@export var args: Array
@onready var event_singletons: Dictionary = {
	"ui_events": UIEvents
}


func emit() -> void:
	event_singletons[event_type].get(event_name).emit(args)
