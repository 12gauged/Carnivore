extends Control

# warning-ignore:unused_signal
signal paused
# warning-ignore:unused_signal
signal resumed

var can_pause: bool = false

func _ready(): 
	# warning-ignore:return_value_discarded
	gui_events.connect("scene_changed_without_fading", self, "_on_scene_changed_without_fading")
	# warning-ignore:return_value_discarded
	gui_events.connect("black_overlay_anim_finished", self, "_on_black_overlay_anim_finished")
	self.visible = false

func _input(event):
	if event.is_action_pressed("ui_return"):
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
