extends Control

# warning-ignore:unused_signal
signal paused
# warning-ignore:unused_signal
signal resumed


func _ready(): self.visible = false

func _input(event):
	if event.is_action_pressed("ui_return"):
		toggle_pause()

func toggle_pause():
	game_functions.toggle_pause()
	self.visible = game_functions.is_game_paused()
	emit_signal("paused" if visible else "resumed")
