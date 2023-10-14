extends Node


@export var scene_name: String = ""
@export_enum("levels", "ui") var scene_type: String = "levels"


func change_scene() -> void:
	get_tree().paused = false
	Game.change_scene(scene_name, scene_type)
