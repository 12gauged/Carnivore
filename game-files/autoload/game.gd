extends Node


signal change_scene_request(scene_name: String, scene_type: String, fade_in: bool)
signal show_black_overlay_request(mode: String)
signal hide_black_overlay_request

signal play_sound_request(stream: AudioStream, bus: String)


func change_scene(scene_name: String, scene_type: String, fade_in: bool) -> void:
	change_scene_request.emit(scene_name, scene_type, fade_in)
	
	
func show_black_overlay(mode: String) -> void:
	show_black_overlay_request.emit(mode)
	
	
func hide_black_overlay() -> void:
	hide_black_overlay_request.emit()
	
	
func play_sound(stream: AudioStream, bus: String) -> void:
	play_sound_request.emit(stream, bus)
