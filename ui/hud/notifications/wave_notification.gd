extends Label

const DEFAULT_TEXT = "hud.wave_indicator"

onready var NotificationDisappearTimer = $notification_disappear_delay
var current_wave: int = 1



func _ready():
	self.visible = false
	# warning-ignore:return_value_discarded
	game_events.connect("wave_finished", self, "_on_game_wave_finished")
	
	
	
func _on_game_wave_finished():
	current_wave += 1
	self.text = tr(DEFAULT_TEXT) % current_wave
	self.visible = true
	NotificationDisappearTimer.start()

func _on_notification_disappear_delay_timeout():
	self.visible = false
