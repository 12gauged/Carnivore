extends Node


signal change_scene_request(scene_name: String, scene_type: String)


func change_scene(scene_name: String, scene_type: String) -> void:
	change_scene_request.emit(scene_name, scene_type)
