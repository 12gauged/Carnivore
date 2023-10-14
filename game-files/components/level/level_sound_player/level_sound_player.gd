extends Node


@export var stream: AudioStream


func play_sound() -> void:
	Game.play_sound(stream)
