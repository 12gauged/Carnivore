extends Control


var menus: Dictionary = {}
var open_ui_key: String
@onready var black_overlay: ColorRect = $BlackOverlay


func _ready() -> void:
	UIEvents.open_ingame_ui.connect(open_ingame_ui)
	UIEvents.close_ingame_ui.connect(close_ingame_ui)
	black_overlay.visible = false
	
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
	black_overlay.visible = true
	menus[ui_name].visible = true
	get_tree().paused = true
	
	
func close_ingame_ui(_args) -> void:
	get_tree().paused = false
	menus[open_ui_key].visible = false
	black_overlay.visible = false
