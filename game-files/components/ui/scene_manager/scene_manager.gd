@tool
extends Node


signal scene_changed(old: String, new: String)
signal started_changing_scenes
signal finished_changing_scenes
var scenes: Dictionary = {}
var new_scene_key: String
var new_scene_type: String


func _ready() -> void:
	Game.change_scene_request.connect(change_scene)
	UIEvents.black_overlay_faded_in.connect(on_black_overlay_faded_in)


func change_scene(new_scene: String, scene_type: String, fade: bool) -> void:
	new_scene_key = new_scene
	new_scene_type = scene_type
	
	if not fade:
		swap_scene_nodes()
		return
	
	Game.show_black_overlay("fade_in")
	started_changing_scenes.emit()
	
	
func add_scene(scene_name, scene_type) -> void:
	var new_scene_packed: PackedScene = str_to_var(scenes[scene_type][scene_name])
	var new_scene: Node = new_scene_packed.instantiate()
	new_scene.ready.connect(on_scene_ready)
	new_scene.set_process_mode(new_scene.PROCESS_MODE_PAUSABLE)
	self.add_child.call_deferred(new_scene)
	
	
func on_black_overlay_faded_in() -> void:
	swap_scene_nodes()
	Game.show_black_overlay("fade_out")
	

# removes the old scene and replaces it
# with the new one.
func swap_scene_nodes() -> void:
	if get_child_count() > 0:
		get_child(0).queue_free()
	add_scene(new_scene_key, new_scene_type)
	get_tree().paused = false
	finished_changing_scenes.emit()	
	
	
func on_scene_ready() -> void:
	GameEvents.scene_finished_changing.emit()


func _on_scene_loader_scenes_loaded(loaded_scenes):
	scenes = loaded_scenes
