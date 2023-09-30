@tool
extends Node


signal scene_changed(old: String, new: String)
var scenes: Dictionary = {}


func _ready() -> void:
	Game.change_scene_request.connect(change_scene)


func change_scene(new_scene: String, scene_type: String) -> void:
	if get_child_count() > 0:
		get_child(0).queue_free()
	add_scene(new_scene, scene_type)
	
	
func add_scene(scene_name, scene_type) -> void:
	var new_scene_packed: PackedScene = str_to_var(scenes[scene_type][scene_name])
	var new_scene = new_scene_packed.instantiate()
	self.add_child(new_scene)


func _on_scene_loader_scenes_loaded(loaded_scenes):
	scenes = loaded_scenes
