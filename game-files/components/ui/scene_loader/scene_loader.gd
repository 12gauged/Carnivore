@tool
extends Node


signal scenes_loaded(scenes)
@export_dir var levels_dir: String
@export_dir var ui_dir: String
var scenes: Dictionary = {}


func _ready() -> void:
	if not OS.is_debug_build() or OS.get_name() in ["Android", "iOS"]:
		var scenes_file = FileAccess.open("res://data/scenes.json", FileAccess.READ)
		scenes = JSON.parse_string(scenes_file.get_as_text())
		scenes_loaded.emit(scenes)
		return
	
	scenes["levels"] = get_files(levels_dir)
	scenes["ui"] = get_files(ui_dir)
	
	var scenes_file = FileAccess.open("res://data/scenes.json", FileAccess.WRITE)
	scenes_file.store_string(JSON.stringify(scenes, "\t"))
	scenes_file.close()
	scenes_loaded.emit(scenes)


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
				result[key] = var_to_str(load("%s/%s" % [current_dir, file_name]))
	return result
