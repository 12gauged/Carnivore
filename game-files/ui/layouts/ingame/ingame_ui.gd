extends Control


@onready var color_rect: ColorRect = $ColorRect
var menus: Dictionary = {}
var open_ui_key: String


func _ready() -> void:
	Game.change_scene_request.connect(on_scene_changing)
	UIEvents.open_ingame_ui.connect(open_ingame_ui)
	UIEvents.close_ingame_ui.connect(close_ingame_ui)
	color_rect.hide()
	
	for child in get_children():
		if not child is Control: continue
		menus[child.name.to_snake_case()] = child
		child.visible = false
	
	
func open_ingame_ui(args: Array) -> void:
	var ui_name: String = args[0]
	open_ui_key = ui_name
	
	if not ui_name in menus.keys():
		push_error("%s not present in menus.keys()" % ui_name)
		return
	color_rect.show()
	menus[ui_name].visible = true
	get_tree().paused = true
	
	
func close_ingame_ui(_args) -> void:
	get_tree().paused = false
	menus[open_ui_key].visible = false
	color_rect.hide()
	
	
func on_scene_changing(_scene_name, _scene_type) -> void:
	get_parent().set_layer(0)
