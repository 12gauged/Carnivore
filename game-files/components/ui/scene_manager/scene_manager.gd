extends Node


signal scene_changed(old: String, new: String)
@export var default_scene: PackedScene
@export_dir var levels_dir: String
@export_dir var ui_dir: String
var scenes: Dictionary = {}


func _ready() -> void:
	scenes["levels"] = get_files(levels_dir)
	scenes["ui"] = get_files(ui_dir)
	Game.change_scene_request.connect(change_scene)
	
	self.add_child(default_scene.instantiate())
	
	
func get_files(path: String) -> Dictionary:
	var directory: DirAccess = DirAccess.open(path)
	var folders: PackedStringArray = directory.get_directories()
	var result: Dictionary = {}
	
	for folder_name in folders:
		directory.change_dir("%s/%s" % [path, folder_name])
		for file_name in directory.get_files():
			if ".tscn" in file_name:
				var key = file_name.replace(".tscn", "")
				var current_dir = directory.get_current_dir()
				result[key] = load("%s/%s" % [current_dir, file_name])
		
	return result


func change_scene(new_scene: String, scene_type: String) -> void:
	if get_child_count() > 0:
		get_child(0).queue_free()
	add_scene(new_scene, scene_type)
	
	
func add_scene(scene_name, scene_type) -> void:
	var new_scene_packed: PackedScene = scenes[scene_type][scene_name]
	var new_scene = new_scene_packed.instantiate()
	self.add_child(new_scene)
