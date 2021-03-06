extends Control

onready var CurrentScene: Control = $current_scene
onready var BlackOverlay: CanvasLayer = $black_overlay

var scene_ref: PackedScene

func _ready():
	# warning-ignore:return_value_discarded
	game_events.connect("change_scene_request", self, "_on_change_scene_request")

func _on_change_scene_request(new_scene, fading: bool = true, fading_speed: float = 1.0):
	scene_ref = resources.get_resource("scenes", new_scene)
	
	if fading:
		BlackOverlay.set_fading_speed(fading_speed)	
		BlackOverlay.fade_in()
		return
	set_current_scene(scene_ref)
		
func set_current_scene(scene) -> void:
	CurrentScene.get_child(0).queue_free()
	CurrentScene.add_child(scene.instance())


func _on_black_overlay_fade_in_finished():
	set_current_scene(scene_ref)
	BlackOverlay.fade_out()
