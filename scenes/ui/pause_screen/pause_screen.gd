extends Control

# warning-ignore:unused_signal
signal paused
# warning-ignore:unused_signal
signal resumed


onready var PauseUIContainer: CenterContainer = $pause_ui_container
onready var GoToMainMenuMethodCaller: Node2D = $pause_ui_container/go_to_main_menu_method_caller
onready var GoToJailMethodCaller: Node2D = $pause_ui_container/go_to_jail_method_caller
onready var UnpauseMethodCaller: Node2D = $pause_ui_container/unpause_method_caller
onready var SettingsUIContainer: Control = $settings_ui_container
onready var SettingsScreen: Control = $settings_ui_container/settings
onready var PopUpWarn: Control = $popup_warn

var popup_warn_open: bool = false

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

	if event.is_action_pressed("controls_pause") and PauseUIContainer.visible:
		toggle_pause()

func toggle_pause():
	if !game_data.can_pause: return
	
	game_functions.toggle_pause()
	self.visible = game_functions.is_game_paused()
	emit_signal("paused" if visible else "resumed")
	
	
func exit_game():
	match game_data.current_level:
		"arena": GoToJailMethodCaller.call_method()
		_: GoToMainMenuMethodCaller.call_method()
	
	
func _on_black_overlay_anim_finished(anim_name): 
	game_data.can_pause = anim_name == "fade_out"
func _on_scene_changed_without_fading(): 
	game_data.can_pause = true

func _on_arena_ended():
	game_data.can_pause = false
	

func disable_pausing(): game_data.can_pause = false	
func enable_pausing(): game_data.can_pause = true	



func _on_home_button_pressed():
	if game_data.progress_safe:
		exit_game()
		UnpauseMethodCaller.call_method()
		return
	
	gui_events.emit_signal("warning_request", "lose_progress", "ui.pause_screen.lose_progress", true, true)
	# warning-ignore:return_value_discarded
	gui_events.connect("warning_request_accepted", self, "_on_warning_accepted")



func _on_warning_accepted(warning_id: String):
	if warning_id != "lose_progress": return
	exit_game()
	UnpauseMethodCaller.call_method()


func _on_settings_button_pressed(id):
	if id != "main_screen": return
	SettingsUIContainer.visible = false
	PauseUIContainer.visible = true
