extends Node


@export var scene_name: String = ""
@export var fade_in: bool = true
@export_enum("levels", "ui") var scene_type: String = "levels"


func change_scene() -> void:
	Game.change_scene(scene_name, scene_type, fade_in)
