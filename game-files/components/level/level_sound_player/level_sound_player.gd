extends Node


@export var stream: AudioStream
@export_enum("Master", "UI", "Music", "Entities", "Actions") var bus: String = "Master"


func play_sound() -> void:
	if stream == null:
		push_warning("audio stream not provided")
		return
	
	Game.play_sound(stream, bus)
