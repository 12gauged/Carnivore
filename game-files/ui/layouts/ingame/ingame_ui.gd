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
	var fade_in: bool = false
	var fade_duration: float = 1.0
	open_ui_key = ui_name
	
	match len(args):
		2:
			fade_in = args[1]
		4:
			fade_in = args[1]
			fade_duration = args[3]
	
	if not ui_name in menus.keys():
		push_error("%s not present in menus.keys()" % ui_name)
		return
	
	var menu: Control = menus[ui_name]
	if fade_in:
		menu.modulate = Color.TRANSPARENT
		color_rect.modulate = Color.TRANSPARENT
		fade_in(menu, fade_duration)
	menu.show()
	color_rect.show()	
	get_tree().paused = true
	
	
func fade_in(menu: Control, fade_duration: float = 1.0) -> void:
	var tween: Tween = create_tween()
	tween.tween_property(menu, "modulate", Color.WHITE, 1.0)
	tween.parallel().tween_property(color_rect, "modulate", Color.WHITE, fade_duration)
	
	
func fade_out(menu: Control, fade_duration: float = 1.0) -> void:
	var tween: Tween = create_tween()
	tween.tween_property(menu, "modulate", Color.TRANSPARENT, 1.0)
	tween.parallel().tween_property(color_rect, "modulate", Color.TRANSPARENT, fade_duration)
	tween.tween_callback(color_rect.hide)
	tween.tween_callback(menu.hide)
	
	
func close_ingame_ui(args: Array = []) -> void:
	var fade_out: bool = false
	var fade_duration: float = 1.0
	
	match len(args):
		3:
			fade_out = args[2]
		4:
			fade_out = args[2]
			fade_duration = args[3]
	
	var menu: Control = menus[open_ui_key]
	get_tree().paused = false	
	if fade_out:
		fade_out(menu, fade_duration)
		return
	menu.hide()
	color_rect.hide()
	
	
func on_scene_changing(_scene_name, _scene_type, _fade) -> void:
	return
	get_parent().set_layer(0)
