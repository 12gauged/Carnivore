extends HBoxContainer


onready var video_tab = $VBoxContainer/video_tab
onready var audio_tab = $VBoxContainer/audio_tab
onready var language_tab = $VBoxContainer/language_tab
onready var storage_tab = $VBoxContainer/storage_tab

func _on_tab_button_pressed(id):
	video_tab.visible = id == "video"
	audio_tab.visible = id == "audio"
	language_tab.visible = id == "language"
	storage_tab.visible = id == "storage"
