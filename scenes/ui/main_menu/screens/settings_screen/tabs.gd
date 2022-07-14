extends HBoxContainer


onready var video_tab = $video_tab
onready var audio_tab = $audio_tab


func _on_tab_button_pressed(id):
	video_tab.visible = id == "video"
	audio_tab.visible = id == "audio"
