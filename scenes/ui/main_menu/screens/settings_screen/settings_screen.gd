extends MenuScreen

const TAB_PATH = "main_settings_container/elements/main_container/tab_buttons/%s"

onready var LayoutEditor = $mobile_layout_editor
onready var MainSettings = $main_settings_container


func hide_tab(tab: String):
	get_node(TAB_PATH % tab).visible = false
func show_tab(tab: String):
	get_node(TAB_PATH % tab).visible = true


func _on_show_mobile_layout_editor_request():
	MainSettings.visible = false
	LayoutEditor.visible = true
	
func _on_hide_mobile_layout_editor_request():
	MainSettings.visible = true
	LayoutEditor.visible = false
