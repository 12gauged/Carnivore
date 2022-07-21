extends Label

const DEFAULT_TEXT = "hud.wave_indicator"
const VILLAGE_SAVED = "ui.victory_screen.village_safe"

onready var NotificationDisappearTimer = $notification_disappear_delay
var current_wave: int = 1

func _ready():
	self.visible = false
	# warning-ignore:return_value_discarded
	game_events.connect("wave_finished", self, "_on_game_wave_finished")
	# warning-ignore:return_value_discarded
	game_events.connect("arena_ended", self, "_on_game_arena_ended")
	
	
func _on_game_wave_finished():
	current_wave += 1
	self.text = tr(DEFAULT_TEXT) % current_wave
	self.visible = true
	NotificationDisappearTimer.start()

func _on_game_arena_ended():
	# Shows the village saved text
	self.text = tr(VILLAGE_SAVED)
	self.visible = true
	NotificationDisappearTimer.start()

func _on_notification_disappear_delay_timeout():
	self.visible = false
