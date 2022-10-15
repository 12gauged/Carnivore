extends MenuScreen

onready var LayoutEditor = $mobile_layout_editor
onready var MainSettings = $main_settings_container

func _on_show_mobile_layout_editor_request():
	MainSettings.visible = false
	LayoutEditor.visible = true
	
func _on_hide_mobile_layout_editor_request():
	MainSettings.visible = true
	LayoutEditor.visible = false
