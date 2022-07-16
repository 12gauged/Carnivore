extends VBoxContainer

onready var video_button = $video_settings
onready var audio_button = $audio_settings
onready var language_button = $language_settings

func _on_tab_button_toggled(button_id):
	video_button.pressed = "video" in button_id
	audio_button.pressed = "audio" in button_id
	language_button.pressed = "language" in button_id
