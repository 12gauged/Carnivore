extends Node


signal change_scene_request(scene_name: String, scene_type: String)
signal show_black_overlay_request(mode)
signal hide_black_overlay_request


func change_scene(scene_name: String, scene_type: String) -> void:
	change_scene_request.emit(scene_name, scene_type)
	
	
func show_black_overlay(mode: String = "%50") -> void:
	show_black_overlay_request.emit(mode)
	
	
func hide_black_overlay() -> void:
	hide_black_overlay_request.emit()
