extends HBoxContainer

onready var video_button = $video_settings
onready var audio_button = $audio_settings
onready var language_button = $language_settings

onready var buttons = {
	"video": $video_settings,
	"audio": $audio_settings,
	"language": $language_settings,
	"controls": $control_settings,
	"storage": $storage_settings
}

onready var last_pressed_button = buttons.video


func _on_tab_button_toggled(button_id):
	buttons[button_id].pressed = true
	last_pressed_button.pressed = false
	last_pressed_button = buttons[button_id]
