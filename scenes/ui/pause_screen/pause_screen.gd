extends Control

# warning-ignore:unused_signal
signal paused
# warning-ignore:unused_signal
signal resumed

onready var ExitGameMethodCaller: Node2D = $pause_ui_container/go_to_main_menu_method_caller
onready var UnpauseMethodCaller: Node2D = $pause_ui_container/unpause_method_caller
onready var SettingsScreen: Control = $settings_ui_container/settings
var can_pause: bool = false

func _ready(): 
	# warning-ignore:return_value_discarded
	game_events.connect("arena_ended", self, "_on_arena_ended")
	# warning-ignore:return_value_discarded
	gui_events.connect("toggle_pause_request", self, "toggle_pause")
	# warning-ignore:return_value_discarded
	gui_events.connect("scene_changed_without_fading", self, "_on_scene_changed_without_fading")
	# warning-ignore:return_value_discarded
	gui_events.connect("black_overlay_anim_finished", self, "_on_black_overlay_anim_finished")
	self.visible = false
	SettingsScreen.hide_tab("storage_settings")

func _input(event):
	if event.is_action_pressed("controls_pause"):
		toggle_pause()

func toggle_pause():
	if !can_pause: return
	
	game_functions.toggle_pause()
	self.visible = game_functions.is_game_paused()
	emit_signal("paused" if visible else "resumed")
	
	
func _on_black_overlay_anim_finished(anim_name): 
	can_pause = anim_name == "fade_out"
func _on_scene_changed_without_fading(): 
	can_pause = true

func _on_arena_ended():
	can_pause = false


func _on_home_button_pressed():
	gui_events.emit_signal("warning_request", "lose_progress", "ui.pause_screen.lose_progress", true, true)
	# warning-ignore:return_value_discarded
	gui_events.connect("warning_request_accepted", self, "_on_warning_accepted")

func _on_warning_accepted(warning_id: String):
	if warning_id != "lose_progress": return
	
	ExitGameMethodCaller.call_method()
	UnpauseMethodCaller.call_method()
