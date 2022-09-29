extends TextureButton

export(String, "video", "audio", "controls", "locale") var setting_group = "video"
export(String) var setting_key = ""


func _ready(): 
	self.pressed = game_data.get_game_setting(setting_group, setting_key)

